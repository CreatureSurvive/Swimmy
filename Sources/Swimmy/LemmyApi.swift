import Foundation
import UniformTypeIdentifiers
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
#if canImport(Dispatch)
import Dispatch
#endif
import CXShim
#if canImport(Combine)
import Combine
#else
import CombineX
#endif

public struct SwimmyVersion {
    public static let version: String = "1.0"
    public static let build: String = "0"
    
    public static var fullVersion: String {
        "\(version).\(build)"
    }
    
    public static var userAgent: String {
        "Swimmy/\(fullVersion); (Lemmy Swift API)"
    }
}


/// An instance of the Lemmy API.
public class LemmyAPI {
    public var retries: Int = 0
    public var userAgent = SwimmyVersion.userAgent
    
    /// the api endpoint eg https://instance.com/api/v3
    public let baseUrl: URL
    /// the pictrs endpoint eg https://instance.com/pictrs/image
    public let pictrsUrl: URL
    /// the instance endpoint eg https://instance.com
    public let instanceUrl: URL
    
    private let additionalHeaders: [String: String]
    private let urlSession: URLSession
    
    public static let headers: [String:String] = [
        "Accept-Encoding" : "gzip",
        "charset" : "UTF-8"
    ]
    
    public static let dispatchQueue: DispatchQueue = {
        return DispatchQueue.init(label: "Swimmy.api", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }()
    
    public static let operationQueue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 10
        queue.qualityOfService = .default
        queue.underlyingQueue = dispatchQueue
        return queue
    }()
    
    public static let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
    }()
    
    public init(baseUrl: URL, headers: [String: String]? = nil, urlSession: URLSession = session) throws {
        self.baseUrl = baseUrl
        guard
            var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false),
            let instanceUrl = {
                components.queryItems = nil
                components.path = ""
                return components.url
            }()
        else {
            throw LemmyAPIError.invalidUrl
        }
        self.instanceUrl = instanceUrl
        self.pictrsUrl = instanceUrl.appending(path: "/pictrs/image")
        self.additionalHeaders = LemmyAPI.headers.merging(headers ?? [:]) { (_, new) in new }
        self.urlSession = urlSession
        if let userAgent = additionalHeaders["User-Agent"] {
            self.userAgent = userAgent
        }
    }
    
    public init(safeBaseUrl: URL, headers: [String: String]? = nil, urlSession: URLSession = session) {
        let rootUrl = safeBaseUrl.getRootUrl
        self.baseUrl = safeBaseUrl
        self.instanceUrl = rootUrl
        self.pictrsUrl = rootUrl.appending(path: "/pictrs/image")
        self.additionalHeaders = LemmyAPI.headers.merging(headers ?? [:]) { (_, new) in new }
        self.urlSession = urlSession
        if let userAgent = additionalHeaders["User-Agent"] {
            self.userAgent = userAgent
        }
    }
    
    public convenience init(baseUrl: String, version: String = "v3", headers: [String: String]? = nil, urlSession: URLSession = session) throws {
        var baseUrl = baseUrl.lowercased()
        let regex = "https?://"
        if baseUrl.range(of: regex, options: .regularExpression) == nil {
            baseUrl = "https://" + baseUrl
        }
        if baseUrl.last == "/" {
            baseUrl = String(baseUrl.dropLast())
        }
        guard let apiURL = URL(string: "\(baseUrl)/api/\(version)") else {
            throw LemmyAPIError.invalidUrl
        }
        
        try self.init(baseUrl: apiURL, headers: headers, urlSession: urlSession)
    }
    
    public func urlRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appending(path: T.path))
        request.httpMethod = T.httpMethod.rawValue
        request.timeoutInterval = timeout
        
        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        if let auth = apiRequest.jwt {
            request.setValue( "Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        if T.httpMethod == .get {
            let mirror = Mirror(reflecting: apiRequest)
            request.url = request.url?
                .appending(queryItems: mirror.children.compactMap { label, value in
                    guard let label = label,
                          let valueString = value as? CustomStringConvertible else { return nil }
                    
                    return URLQueryItem(name: label, value: String(describing: valueString))
                })
        } else {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(apiRequest)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    public func baseRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> (T.Response, URLResponse, Data) {
        let request = try urlRequest(apiRequest, timeout: timeout)
        print("LemmyAPI request: \(request.debugDescription)")
        let (data, response) = try await urlSession.data(for: request)
        
        let code = (response as! HTTPURLResponse).statusCode
        if !(200..<300).contains(code) {
            if let genericError = try? JSONDecoder().decode(GenericError.self, from: data), let reason = genericError.error {
                switch reason {
                case "not_logged_in":
                    throw LemmyAPIError.notLoggedIn
                default:
                    throw LemmyAPIError.lemmyError(message: genericError.error, code: code)
                }
            }
            throw LemmyAPIError.unexpectedStatusCodeDetails("Unexpected status code from LemmyAPI: (\(code)) \(HTTPURLResponse.localizedString(forStatusCode: code))")
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedResult = try decoder.decode(T.Response.self, from: data)
            return (decodedResult, response, data)
        } catch {
            let genericError = try? decoder.decode(GenericError.self, from: data)
            print(genericError?.prettyPrintedJSONString ?? String(data: data, textEncodingName: nil, default: .utf8)!)
            
            
            throw error
        }
    }
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> T.Response {
        let (result, _, _) = try await baseRequest(apiRequest, timeout: timeout)
        return result
    }
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10, response: @escaping (Result<T.Response, Error>) -> Void) throws -> AnyCancellable {
        let request = try urlRequest(apiRequest, timeout: timeout)
        print("LemmyAPI request: \(request.debugDescription)")
        
#if canImport(FoundationNetworking)
        let session = urlSession.cx
#else
        let session = urlSession
#endif
        
        return session.dataTaskPublisher(for: request).mapError { error in
            return LemmyAPIError.network(code: error.code.rawValue, description: error.localizedDescription)
        }
        .tryMap { v in
            let code = (v.response as! HTTPURLResponse).statusCode
            if !(200..<300).contains(code) {
                
                print("unexpectedStatusCode: (\(code)) \(String(data: v.data, encoding: .utf8) ?? "")")
                if let decoded = try? JSONDecoder().decode(GenericError.self, from: v.data) {
                    throw LemmyAPIError.lemmyError(message: decoded.error, code: code)
                }
                throw LemmyAPIError.network(code: code, description: String(data: v.data, encoding: .utf8) ?? "")
            }
            return v
        }
        //        .retryWithDelay(retries: retries, delay: 2, scheduler: LemmyAPI.dispatchQueue.cx)
        .flatMap { v in
            Just(v.data)
                .decode(type: T.Response.self, decoder: JSONDecoder())
                .mapError { error in
                    let decodingError = LemmyAPIError.decoding(
                        message: String(data: v.data, encoding: .utf8) ?? "",
                        error: error as! DecodingError
                    )
                    print("\(error)")
                    return decodingError
                }
                .tryCatch { decodingError in
                    Just(v.data)
                        .decode(type: GenericError.self, decoder: JSONDecoder())
                        .mapError { _ in decodingError }
                        .tryMap { throw LemmyAPIError.lemmyError(message: $0.error, code: 200) }
                }
        }
        .mapError { $0 as! LemmyAPIError }
        .receive(on: DispatchQueue.main.cx)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case let .failure(error):
                response(Result.failure(error))
            }
        }, receiveValue: { value in
            response(Result.success(value))
        })
    }
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10, store: inout Set<AnyCancellable>) async -> (T.Response?, Error?) {
        return await withCheckedContinuation { continuation in
            do {
                try request(apiRequest) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: (response, nil))
                    case .failure(let error):
                        continuation.resume(returning: (nil, error))
                    }
                }.store(in: &store)
            } catch {
                continuation.resume(returning: (nil, error))
            }
        }
    }
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10, store: inout Set<AnyCancellable>) async throws -> T.Response {
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try request(apiRequest) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }.store(in: &store)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10, store: inout Set<AnyCancellable>) async -> Result<T.Response, Error> {
        return await withCheckedContinuation { continuation in
            do {
                try request(apiRequest) { result in
                    continuation.resume(returning: result)
                }.store(in: &store)
            } catch {
                continuation.resume(returning: Result.failure(error))
            }
        }
    }
    
    public func uploadRequest(_ apiRequest: UploadImageRequest) async throws -> UploadImageRequest.Response {
        let request = MultipartFormDataRequest(url: pictrsUrl)
        request.addDataField(named: "images[]", data: apiRequest.image, mimeType: UTType.image.identifier)
        var urlRequest = request.asURLRequest()
        if let auth = apiRequest.auth {
            urlRequest.setValue("jwt=\(auth)", forHTTPHeaderField: "Cookie")
            urlRequest.setValue( "Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        print("LemmyAPI request: \(urlRequest.debugDescription)")
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        try checkResponse(response, data: data)
        
        let decoder = JSONDecoder()
        
        do {
            let decodedResult = try decoder.decode(UploadImageRequest.Response.self, from: data)
            return decodedResult
        } catch {
            let genericError = try? decoder.decode(GenericError.self, from: data)
            print(genericError?.prettyPrintedJSONString ?? String(data: data, textEncodingName: nil, default: .utf8)!)
            
            if let genericError = genericError {
                throw LemmyAPIError.genericError("lemmy returned an error: \(error). response: \(genericError)")
            }
            
            throw error
        }
    }
    
    public func checkResponse(_ response: URLResponse, data: Data?) throws {
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            let genericError = checkGenericError(data)
            
            if let genericError = genericError {
                throw LemmyAPIError.genericError(
                    """
                    lemmy returned an error: \(genericError)
                    with an unexpected status code from LemmyAPI: (\(response.statusCode))
                    \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                    """
                )
            }
            
            throw LemmyAPIError.unexpectedStatusCodeDetails("Unexpected status code from LemmyAPI: (\(response.statusCode)) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
        }
    }
    
    func checkGenericError(_ data: Data?) -> GenericError? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(GenericError.self, from: data)
    }
}

extension LemmyAPI {
    
    /// finds the correct api endpoint for a lemmy instance base url
    /// throws: `LemmyAPIError.endpointResolveError` if the endpoint could not be resolved
    public static func getApiEndpoint(baseInstanceAddress: String) async throws -> URL {
        var validAddress: URL?
        
        let baseURLString = (baseInstanceAddress.hasSuffix("/") ? String(baseInstanceAddress.dropLast(1)) as String : baseInstanceAddress)
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "www.", with: "")
            .lowercased()
        
        let possibleInstanceAddresses = [
            URL(string: "https://\(baseURLString)/api/v3/site"),
            URL(string: "https://\(baseURLString)/api/v2/site"),
            URL(string: "https://\(baseURLString)/api/v1/site")
        ].compactMap{ $0 }
        
        for address in possibleInstanceAddresses {
            if await checkIfEndpointExists(at: address) {
                print("\(address) is valid")
                validAddress = address.deletingLastPathComponent()
                break
            } else {
                print("\(address) is invalid")
                continue
            }
        }
        
        if let validAddress = validAddress {
            return validAddress
        }
        
        throw LemmyAPIError.endpointResolveError(baseInstanceAddress)
    }

    /// takes a url that points to a valid lemmy api endpoint that responds to GET requests
    /// returns true if the endpoint responds with a status of 200
    public static func checkIfEndpointExists(at url: URL) async -> Bool {
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(2)
        
        do {
            let (_, response) = try await session.data(for: request)
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            
            print("Response for endpoint \(url) is \(httpResponse.statusCode)")
            
            return  httpResponse.statusCode == 200
        } catch {
            return false
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public enum LemmyAPIError: Error {
    case network(code: Int, description: String)
    case lemmyError(message: String?, code: Int)
    case decoding(message: String, error: DecodingError)
    case unexpectedStatusCode(Int)
    case unexpectedStatusCodeDetails(String)
    case genericError(String)
    case notLoggedIn
    case invalidUrl
    case endpointResolveError(String)
}

public struct GenericError: Codable {
    public let error: String?
}

extension LemmyAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpectedStatusCode(let status):
            return "lemmy returned an unexpected status: \(status)"
        case .unexpectedStatusCodeDetails(let details):
            return "lemmy returned an unexpected status: \(details)"
        case .genericError(let error):
            return "lemmyAPI encountered an unexpected error: \(error)"
        case .notLoggedIn:
            return "user not logged in, or session expired"
        case .network(let code, let description):
            return "LemmyApi received a network error: code \(code), reason: \(description)"
        case .lemmyError(let message, let code):
            switch message {
            case "not_logged_in":
                return "user not logged in, or session expired"
            default:
                return "LemmyApi lemmy returned an error: code \(code), reason: \(message ?? "unknown")"
            }
        case .decoding(let message, let error):
            return "LemmyApi could not decode response: \(message), reason: \(error.localizedDescription)"
        case .invalidUrl:
            return "lemmyAPI base url is invalid"
        case .endpointResolveError:
            return "Failed to resolve endpoint: check the instance url"
        }
    }
}

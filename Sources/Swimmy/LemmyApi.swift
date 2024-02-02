import Foundation
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

let decoder = {
    let decoder = JSONDecoder()
#if os(Linux)
    return decoder.cx
#else
    return decoder
#endif
}()


/// An instance of the Lemmy API.
public class LemmyAPI {
    
    private static let redact_keys = [
        "auth", "password", "new_password", "new_password_verify", "old_password", "totp_2fa_token", "captcha_answer", "captcha_uuid"
    ]
    
    public static let dispatchQueue: DispatchQueue = {
        return DispatchQueue.init(label: "Swimmy.api", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }()
    
    public static let operationQueue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.name = "com.creaturecoding.swimmy.api"
        queue.maxConcurrentOperationCount = 10
        queue.qualityOfService = .default
        queue.underlyingQueue = dispatchQueue
        return queue
    }()
    
    public static let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
    }()
    
    public static let headers: [String:String] = [
        "Accept-Encoding" : "gzip",
        "charset" : "UTF-8"
    ]
    
    public var retries: Int = 0
    public var userAgent = SwimmyVersion.userAgent
    
    /// the api endpoint eg https://instance.com/api/v3
    public let baseUrl: URL
    /// the pictrs endpoint eg https://instance.com/pictrs/image
    public let pictrsUrl: URL
    /// the instance endpoint eg https://instance.com
    public let instanceUrl: URL
    
    /// an optional set of additional headers that will be sent with api requests
    /// for instance you can set the User-Agent
    private let additionalHeaders: [String: String]
    private let urlSession: URLSession
    
    
    /// initialize the LemmyAPI with an instance api `URL`
    /// this method does not perform any safety checks to ensure the url is the correct format
    ///
    /// - Parameters:
    ///     - safeBaseUrl: the instance (*https://instance.site/api/v3*).
    ///     - version: the api version eg: *v3*.
    ///     - headers: additional headers to send with all requests. eg: User-Agent.
    ///     - urlSession: optionally specify the URLSession that requests will be sent on
    ///
    /// - Throws: `LemmyAPIError.invalidUrl`
    ///            if `baseUrl` is invalid, or in an unsupported format
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
    
    /// initialize the LemmyAPI with an instance api `URL`
    /// this method does not perform any safety checks to ensure the url is the correct format
    ///
    /// - Parameters:
    ///     - safeBaseUrl: the instance (*https://instance.site/api/v3*).
    ///     - version: the api version eg: *v3*.
    ///     - headers: additional headers to send with all requests. eg: User-Agent.
    ///     - urlSession: optionally specify the URLSession that requests will be sent on
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
    
    /// initialize the LemmyAPI with an instance string
    ///
    /// - Parameters:
    ///     - baseUrl: the instance (*https://instance.site* | *instance.site*).
    ///     - version: the api version eg: *v3*.
    ///     - headers: additional headers to send with all requests. eg: User-Agent.
    ///     - urlSession: optionally specify the URLSession that requests will be sent on
    ///
    /// - Throws: `LemmyAPIError.invalidUrl`
    ///            if `baseUrl` is invalid, or in an unsupported format
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
    
    public func urlRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) -> URLRequest {
        var request = URLRequest(url: baseUrl.appending(path: path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        
        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = body?.data(using: .utf8)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        if let auth = auth {
            request.setValue( "Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    /// builds a URLRequest from an instance of `APIRequest`
    ///
    /// - Parameters:
    ///     - apiRequest: the `APIRequest` object to build the request from
    ///     - timeout: optionally specify a timeout for the request, default value is `10` seconds.
    ///
    /// - Throws: `EncodingError.invalidValue(_:_:)`
    ///            if `apiRequest` contains data that cannot be encoded using the `JSONEncoder`
    public func urlRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) throws -> URLRequest {
        var request = urlRequest(
            path: T.path,
            body: nil,
            contentType: "application/json",
            auth: apiRequest.jwt,
            method: T.httpMethod,
            timeout: timeout)
        
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
        
        return request
    }
    
#if !os(Linux)
    
    public func performRequestWithCheckedResponse(_ request: URLRequest) async throws -> (URLResponse, Data) {
        if let redactedUrl = request.url?.redacting(queryItems: Self.redact_keys) {
            SwimmyLogger.log("LemmyAPI request: \(redactedUrl)", logType: .info)
        }
        let (data, response) = try await urlSession.data(for: request)
        
        let code = (response as! HTTPURLResponse).statusCode
        if !(200..<300).contains(code) {
            if let genericError = try? decoder.decode(GenericError.self, from: data), let reason = genericError.error {
                switch reason {
                case "not_logged_in", "incorrect_login":
                    throw LemmyAPIError.notLoggedIn
                default:
                    throw LemmyAPIError.lemmyError(message: genericError.error, code: code)
                }
            }
            throw LemmyAPIError.unexpectedStatusCodeDetails("Unexpected status code from LemmyAPI: (\(code)) \(HTTPURLResponse.localizedString(forStatusCode: code))")
        }
        
        return (response, data)
    }
    
    /// performs an `APIRequest`
    ///
    /// - Returns: a `Tuple` with the results
    ///            - response: `APIRequest.Response` the decoded response
    ///            - urlResponse: `URLResponse`
    ///            - data: the raw `Data` from the `URLRequest`
    ///
    /// - Parameters:
    ///     - apiRequest: the `APIRequest` object to build the request from
    ///     - timeout: optionally specify a timeout for the request, default value is `10` seconds.
    ///
    /// - Throws: `LemmyAPIError`
    public func baseRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> (URLResponse, Data) {
        let request = try urlRequest(apiRequest, timeout: timeout)
        return try await performRequestWithCheckedResponse(request)
    }
    
    public func baseRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> (URLResponse, Data) {
        let request = urlRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        return try await performRequestWithCheckedResponse(request)
    }

    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> T.Response {
        let (_, data) = try await baseRequest(apiRequest, timeout: timeout)
        
        do {
            let decodedResult = try decoder.decode(T.Response.self, from: data)
            return decodedResult
        } catch {
            throw checkDecodingError(error, data: data)
        }
    }
    
    public func stringRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> String {
        let (_, data) = try await baseRequest(apiRequest, timeout: timeout)
        
        guard let string = String(data: data, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(
                message: "LemmyAPI error decoding response \(data)")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func stringRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> String {
        let (_, data) = try await baseRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        
        guard let string = String(data: data, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(
                message: "LemmyAPI error decoding response \(data)")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func dataRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Data {
        let (_, data) = try await baseRequest(apiRequest, timeout: timeout)
        
        return data
    }
    
    public func dataRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Data {
        let (_, data) = try await baseRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        
        return data
    }
    
    public func statusRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, data) = try await baseRequest(apiRequest, timeout: timeout)
        
        do {
            _ = try decoder.decode(T.Response.self, from: data)
            return true
        } catch {
            do {
                let decodedResult = try decoder.decode(SuccessResponse.self, from: data)
                return decodedResult.success
            } catch {
                throw checkDecodingError(error, data: data)
            }
        }
    }
    
    public func statusRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, data) = try await baseRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        
        do {
            let decodedResult = try decoder.decode(SuccessResponse.self, from: data)
            return decodedResult.success
        } catch {
            throw checkDecodingError(error, data: data)
        }
    }
    
#endif
    
    public func request<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10, response: @escaping (Result<T.Response, Error>) -> Void) throws -> AnyCancellable {
        let request = try urlRequest(apiRequest, timeout: timeout)
        if let redactedUrl = request.url?.redacting(queryItems: Self.redact_keys) {
            SwimmyLogger.log("LemmyAPI request: \(redactedUrl)", logType: .info)
        }
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
                
                SwimmyLogger.log("unexpectedStatusCode: (\(code)) \(String(data: v.data, encoding: .utf8) ?? "")", logType: .error)
                if let decoded = try? decoder.decode(GenericError.self, from: v.data) {
                    throw LemmyAPIError.lemmyError(message: decoded.error, code: code)
                }
                throw LemmyAPIError.network(code: code, description: String(data: v.data, encoding: .utf8) ?? "")
            }
            return v
        }
        //        .retryWithDelay(retries: retries, delay: 2, scheduler: LemmyAPI.dispatchQueue.cx)
        .flatMap { v in
            Just(v.data)
                .decode(type: T.Response.self, decoder: decoder)
                .mapError { error in
                    let decodingError = LemmyAPIError.decoding(
                        message: String(data: v.data, encoding: .utf8) ?? "",
                        error: error as! DecodingError
                    )
                    SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
                    return decodingError
                }
                .tryCatch { decodingError in
                    Just(v.data)
                        .decode(type: GenericError.self, decoder: decoder)
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
    
#if !os(Linux)
    public func uploadRequest(_ apiRequest: UploadImageRequest) async throws -> UploadImageRequest.Response {
        let request = MultipartFormDataRequest(url: pictrsUrl)
        request.addDataField(named: "images[]", data: apiRequest.image, mimeType: "public.image")
        var urlRequest = request.asURLRequest()
        if let auth = apiRequest.auth {
            urlRequest.setValue("jwt=\(auth)", forHTTPHeaderField: "Cookie")
            urlRequest.setValue( "Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        SwimmyLogger.log("LemmyAPI request: \(urlRequest.debugDescription)", logType: .info)
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        try checkResponse(response, data: data)
        
        do {
            let decodedResult = try decoder.decode(UploadImageRequest.Response.self, from: data)
            return decodedResult
        } catch {
            if let genericError = try? decoder.decode(GenericError.self, from: data) {
                SwimmyLogger.log("LemmyAPI generic error: \(genericError.json)", logType: .error)
            }
            
            let decodingError = LemmyAPIError.decoding(
                message: String(data: data, encoding: .utf8) ?? "",
                error: error as! DecodingError
            )
            
            SwimmyLogger.log("LemmyAPI error decoding response: \(decodingError)", logType: .error)
            
            throw decodingError
        }
    }
#endif
    
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
        return try? decoder.decode(GenericError.self, from: data)
    }
    
    private func checkDecodingError(_ error: Error, data: Data) -> Error {
        if let genericError = try? decoder.decode(GenericError.self, from: data) {
            SwimmyLogger.log("LemmyAPI generic error: \(genericError.json)", logType: .error)
        }
        
        let decodingError = LemmyAPIError.decoding(
            message: String(data: data, encoding: .utf8) ?? "",
            error: error as! DecodingError
        )
        
        SwimmyLogger.log("LemmyAPI error decoding response: \(decodingError)", logType: .error)
        
        return error
    }
}

extension LemmyAPI {
    
#if !os(Linux)
    /// finds the correct api endpoint for a lemmy instance base url
    /// - Throws: `LemmyAPIError.endpointResolveError` if the endpoint could not be resolved
    /// - Returns: the url of the resolved api endpoint of the `baseInstanceAddress`
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
                SwimmyLogger.log("\(address) is valid")
                validAddress = address.deletingLastPathComponent()
                break
            } else {
                SwimmyLogger.log("\(address) is invalid")
                continue
            }
        }
        
        if let validAddress = validAddress {
            return validAddress
        }
        
        throw LemmyAPIError.endpointResolveError(baseInstanceAddress)
    }

    /// takes a url that points to a valid lemmy api endpoint that responds to GET requests
    /// - Returns: true if the endpoint responds with a status of 200
    public static func checkIfEndpointExists(at url: URL) async -> Bool {
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(2)
        
        do {
            let (_, response) = try await session.data(for: request)
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            
            SwimmyLogger.log("Response for endpoint \(url) is \(httpResponse.statusCode)")
            
            return  httpResponse.statusCode == 200
        } catch {
            return false
        }
    }
#endif
}

enum AsyncError: Error {
    case finishedWithoutValue
}

extension AnyPublisher {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(throwing: AsyncError.finishedWithoutValue)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(with: .success(value))
                }
        }
    }
}

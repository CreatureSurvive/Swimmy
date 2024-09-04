//
//  LemmyAPIAsyncClient.swift
//
//
//  Created by Dana Buehre on 9/3/24.
//

import Foundation
import NIOCore
#if os(Linux)
import NIOFoundationCompat
#endif

#if canImport(AsyncHTTPClient)
import AsyncHTTPClient

// MARK: AsyncHTTPClient
extension LemmyAPI {
    
    public func httpRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) -> HTTPClientRequest {
        var request = HTTPClientRequest(url: baseUrl.appending(path: path).absoluteString)
        switch method {
        case .get: request.method = .GET
        case .put: request.method = .PUT
        case .post: request.method = .POST
        }
        
        for (key, value) in additionalHeaders {
            request.headers.add(name: key, value: value)
        }
        
        if let body = body {
            request.body = .bytes(.init(string: body))
        }
        
        request.headers.add(name: "User-Agent", value: userAgent)
        
        if let auth = auth {
            request.headers.add(name: "Authorization", value: "Bearer \(auth)")
        }
        
        request.headers.add(name: "Content-Type", value: contentType)
        return request
    }
    
    public func httpRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) throws -> HTTPClientRequest {
        var request = httpRequest(
            path: T.path,
            body: nil,
            contentType: "application/json",
            auth: apiRequest.jwt,
            method: T.httpMethod,
            timeout: timeout)
        
        if T.httpMethod == .get, let url = request.url.asURL {
            let mirror = Mirror(reflecting: apiRequest)
            if let newUrl = url.appending(queryItems: mirror.children.compactMap { label, value in
                    guard let label = label,
                          let valueString = value as? CustomStringConvertible else { return nil }
                    
                    return URLQueryItem(name: label, value: String(describing: valueString))
                })?.absoluteString {
                request.url = newUrl
            }
        } else {
            let encoder = JSONEncoder()
            let buffer = try encoder.encodeAsByteBuffer(
                apiRequest,
                allocator: ByteBufferAllocator()
            )
            request.body = .bytes(buffer)
        }
        
        return request
    }
    
    public func baseHTTPRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, Data?) {
        let request = try httpRequest(apiRequest, timeout: timeout)
        return try await performRequestWithCheckedResponse(request, timeout: timeout)
    }
    
    public func baseHTTPRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, Data?) {
        let request = httpRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        return try await performRequestWithCheckedResponse(request, timeout: timeout)
    }
    
    public func performRequestWithCheckedResponse(_ request: HTTPClientRequest, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, Data?) {
        if let redactedUrl = request.url.asURL?.redacting(queryItems: Self.redact_keys) {
            SwimmyLogger.log("LemmyAPI request: \(redactedUrl)", logType: .info)
        }
        let response = try await httpClient.execute(request, timeout: .seconds(Int64(timeout)))
        
        var buffer: ByteBuffer = .init()
        for try await var chunk in response.body {
            buffer.writeBuffer(&chunk)
        }
        let data = buffer.getData(at: 0, length: buffer.readableBytes)
        
        if !(200..<300).contains(response.status.code) {
            if data != nil, let genericError = try? decoder.decode(GenericError.self, from: data!), let reason = genericError.error {
                switch reason {
                case "not_logged_in", "incorrect_login":
                    throw LemmyAPIError.notLoggedIn
                default:
                    throw LemmyAPIError.lemmyError(message: genericError.error, code: Int(response.status.code))
                }
            }
            throw LemmyAPIError.unexpectedStatusCodeDetails("Unexpected status code from LemmyAPI: (\(response.status) \(response.status.code)) \(response.status.reasonPhrase)")
        }
        
        return (response, data)
    }
    
    public func asyncRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> T.Response {
        let (_, data) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        
        do {
            let decodedResult = try decoder.decode(T.Response.self, from: data!)
            return decodedResult
        } catch {
            throw checkDecodingError(error, data: data)
        }
    }
    
    public func asyncStringRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> String {
        let (_, data) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        
        guard let string = String(data: data!, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(
                message: "LemmyAPI error decoding response \(data!)")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func asyncStringRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> String {
        let (_, data) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        
        guard let string = String(data: data!, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(
                message: "LemmyAPI error decoding response \(data!)")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func asyncDataRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Data {
        let (_, data) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        return data!
    }
    
    public func asyncDataRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Data {
        let (_, data) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        return data!
    }
    
    public func asyncStatusRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, data) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }

        do {
            _ = try decoder.decode(T.Response.self, from: data!)
            return true
        } catch {
            do {
                let decodedResult = try decoder.decode(SuccessResponse.self, from: data!)
                return decodedResult.success
            } catch {
                throw checkDecodingError(error, data: data!)
            }
        }
    }
    
    public func asyncStatusRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, data) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        guard data != nil else { throw LemmyAPIError.noDataReceived }
        
        do {
            let decodedResult = try decoder.decode(SuccessResponse.self, from: data!)
            return decodedResult.success
        } catch {
            throw checkDecodingError(error, data: data!)
        }
    }
}
#endif

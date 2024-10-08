//
//  LemmyAPIAsyncClient.swift
//
//
//  Created by Dana Buehre on 9/3/24.
//

import Foundation
#if canImport(NIOCore)
import NIOCore
#endif
#if os(Linux) && canImport(NIOCore)
import NIOFoundationCompat
#endif

#if canImport(AsyncHTTPClient) && canImport(NIOCore)
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
    
    public func baseHTTPRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, ByteBuffer) {
        let request = try httpRequest(apiRequest, timeout: timeout)
        return try await performRequestWithCheckedResponse(request, timeout: timeout)
    }
    
    public func baseHTTPRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, ByteBuffer) {
        let request = httpRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        return try await performRequestWithCheckedResponse(request, timeout: timeout)
    }
    
    public func performRequestWithCheckedResponse(_ request: HTTPClientRequest, timeout: TimeInterval = 10) async throws -> (HTTPClientResponse, ByteBuffer) {
        if let redactedUrl = request.url.asURL?.redacting(queryItems: Self.redact_keys) {
            SwimmyLogger.log("LemmyAPI request: \(redactedUrl)", logType: .info)
        }
        let response = try await asyncWrapper.client.execute(request, timeout: .seconds(Int64(timeout)))
        
        var buffer: ByteBuffer = .init()
        for try await var chunk in response.body {
            buffer.writeBuffer(&chunk)
        }
        
        if !(200..<300).contains(response.status.code) {
            if let genericError = try? decoder.decode(GenericError.self, from: buffer), let reason = genericError.error {
                switch reason {
                case "not_logged_in", "incorrect_login":
                    throw LemmyAPIError.notLoggedIn
                default:
                    throw LemmyAPIError.lemmyError(message: genericError.error, code: Int(response.status.code))
                }
            }
            throw LemmyAPIError.unexpectedStatusCodeDetails("Unexpected status code from LemmyAPI: (\(response.status) \(response.status.code)) \(response.status.reasonPhrase)")
        }
        
        return (response, buffer)
    }
    
    public func asyncRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> T.Response {
        let (_, buffer) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard buffer.readableBytes > 0 else { throw LemmyAPIError.noDataReceived }
        
        do {
            let decodedResult = try decoder.decode(T.Response.self, from: buffer)
            return decodedResult
        } catch {
            throw checkDecodingError(error, buffer: buffer)
        }
    }
    
    public func asyncStringRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> String {
        let (_, buffer) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        
        guard let string = buffer.getString(at: 0, length: buffer.readableBytes, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(message: "LemmyAPI error decoding response")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func asyncStringRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> String {
        let (_, buffer) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        
        guard let string = buffer.getString(at: 0, length: buffer.readableBytes, encoding: .utf8) else {
            let error = LemmyAPIError.stringDecoding(message: "LemmyAPI error decoding response")
            SwimmyLogger.log("LemmyAPI error decoding response: \(error)", logType: .error)
            throw error
        }
        
        return string
    }
    
    public func asyncDataRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Data {
        let (_, buffer) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard let data = buffer.getData(at: 0, length: buffer.readableBytes, byteTransferStrategy: .noCopy) else {
            throw LemmyAPIError.noDataReceived
        }
        return data
    }
    
    public func asyncDataRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Data {
        let (_, buffer) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        guard let data = buffer.getData(at: 0, length: buffer.readableBytes, byteTransferStrategy: .noCopy) else {
            throw LemmyAPIError.noDataReceived
        }
        return data
    }
    
    public func asyncStatusRequest<T: APIRequest>(_ apiRequest: T, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, buffer) = try await baseHTTPRequest(apiRequest, timeout: timeout)
        guard buffer.readableBytes > 0 else { throw LemmyAPIError.noDataReceived }

        do {
            _ = try decoder.decode(T.Response.self, from: buffer)
            return true
        } catch {
            do {
                let decodedResult = try decoder.decode(SuccessResponse.self, from: buffer)
                return decodedResult.success
            } catch {
                throw checkDecodingError(error, buffer: buffer)
            }
        }
    }
    
    public func asyncStatusRequest(path: String, body: String?, contentType: String, auth: String?, method: HTTPMethod, timeout: TimeInterval = 10) async throws -> Bool {
        let (_, buffer) = try await baseHTTPRequest(path: path, body: body, contentType: contentType, auth: auth, method: method, timeout: timeout)
        guard buffer.readableBytes > 0 else { throw LemmyAPIError.noDataReceived }
        
        do {
            let decodedResult = try decoder.decode(SuccessResponse.self, from: buffer)
            return decodedResult.success
        } catch {
            throw checkDecodingError(error, buffer: buffer)
        }
    }
    
    internal func checkDecodingError(_ error: Error, buffer: ByteBuffer?) -> Error {
        guard buffer != nil else {
            SwimmyLogger.log("LemmyAPI error decoding response:", logType: .error)
            return error
        }
        
        if let genericError = try? decoder.decode(GenericError.self, from: buffer!) {
            SwimmyLogger.log("LemmyAPI generic error: \(genericError.json)", logType: .error)
        }
        
        let decodingError = LemmyAPIError.decoding(
            message: buffer!.getString(at: 0, length: buffer!.readableBytes, encoding: .utf8) ?? "",
            error: error as! DecodingError
        )
        
        SwimmyLogger.log("LemmyAPI error decoding response: \(decodingError)", logType: .error)
        
        return error
    }
}

internal class LazyHTTPClientLoader {
    internal var hasAsyncClient: Bool = false
    internal lazy var client = {
        hasAsyncClient = true
        return HTTPClient(eventLoopGroupProvider: .singleton, configuration: .init(
            certificateVerification: .fullVerification,
            redirectConfiguration: .follow(max: 20, allowCycles: false),
            timeout: .init(connect: .seconds(90), read: .seconds(90), write: .seconds(90)),
            connectionPool: .seconds(600),
            proxy: nil,
            ignoreUncleanSSLShutdown: false,
            decompression: .enabled(limit: .ratio(1000)),
            backgroundActivityLogger: nil
        ))
    }()
}

#endif

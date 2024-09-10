//
//  LemmyAPIImageUpload.swift
//
//
//  Created by Dana Buehre on 9/9/24.
//

import Foundation

extension LemmyAPI {
#if !os(Linux)
    public func uploadRequest(_ apiRequest: UploadImageRequest) async throws -> UploadImageRequest.Response {
        let request = MultipartFormDataRequest(url: pictrsUrl, fieldName: "images[]", data: apiRequest.image, mimeType: "public.image")
        var urlRequest = request.asURLRequest()
        if let auth = apiRequest.auth {
            urlRequest.setValue("jwt=\(auth)", forHTTPHeaderField: "Cookie")
            urlRequest.setValue( "Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        SwimmyLogger.log("LemmyAPI request: \(urlRequest.debugDescription)", logType: .info)
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        do {
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 413 else {
                throw LemmyAPIError.imageTooLarge(request.rawByteCount)
            }
            
            let decodedResult = try decoder.decode(UploadImageRequest.Response.self, from: data)
            
            switch decodedResult.msg {
            case "ok":
                return decodedResult
            case "too_large":
                throw LemmyAPIError.imageTooLarge(request.rawByteCount)
            default:
                throw LemmyAPIError.unhandledResponse("msg: \"\(decodedResult.msg)\"")
            }
        } catch {
            SwimmyLogger.log(error.localizedDescription, logType: .error)
            switch error {
            case LemmyAPIError.imageTooLarge:
                throw error
            case is DecodingError:
                throw error
            case LemmyAPIError.unhandledResponse:
                throw error
            default:
                if let genericError = try? decoder.decode(GenericError.self, from: data).actualError {
                    throw genericError
                }
                
                try checkResponse(response, data: data)
                
                throw error
            }
        }
    }
#endif
}

//
//  LemmyAPIError.swift
//  
//
//  Created by Dana Buehre on 11/12/23.
//

import Foundation

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
    case notAuthorized
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
        case .notAuthorized:
            return "auth (jwt) not set"
        }
    }
}

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
    case stringDecoding(message: String)
    case unexpectedStatusCode(Int)
    case unexpectedStatusCodeDetails(String)
    case genericError(String)
    case genericMessageError(String?, String?)
    case notLoggedIn
    case invalidUrl
    case endpointResolveError(String)
    case notAuthorized
    case noDataReceived
    case imageTooLarge(Int)
    case unhandledResponse(String)

    static let byteCountFormatStyle = ByteCountFormatStyle(style: .file, allowedUnits: .all, spellsOutZero: true, includesActualByteCount: true, locale: Locale.current)
}

public struct GenericError: Codable {
    public let error: String?
    public let message: String?
    
    public var actualError: LemmyAPIError {
        .genericMessageError(error, message)
    }
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
        case .genericMessageError(let error, let message):
            return "lemmyAPI encountered an unexpected error: \(error ?? "unknown"): (\(message ?? "nil"))"
        case .notLoggedIn:
            return "user not logged in, or session expired"
        case .network(let code, let description):
            return "LemmyApi received a network error: code \(code), reason: \(description)"
        case .lemmyError(let message, let code):
            switch message {
            case "not_logged_in", "incorrect_login":
                return "user not logged in, or session expired"
            default:
                return "LemmyApi lemmy returned an error: code \(code), reason: \(message ?? "unknown")"
            }
        case .decoding(let message, let error):
            return "LemmyApi could not decode response: \(message), reason: \(error.localizedDescription)"
        case .stringDecoding(let message):
            return "LemmyApi could not decode response: \(message)"
        case .invalidUrl:
            return "lemmyAPI base url is invalid"
        case .endpointResolveError:
            return "Failed to resolve endpoint: check the instance url"
        case .notAuthorized:
            return "auth (jwt) not set"
        case .noDataReceived:
            return "the request resulted in an empty response body"
        case .imageTooLarge(let bytes):
            return "Uploaded image is too large! \(bytes.formatted(Self.byteCountFormatStyle))"
        case .unhandledResponse(let message):
            return "LemmyAPI returned an unexpected response: (\(message))"
        }
    }
}

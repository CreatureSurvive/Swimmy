//
//  URL.swift
//  
//
//  Created by Dana Buehre on 11/7/23.
//

import Foundation

extension URL {
    
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
    
    // no idea why appendingPathComponent is not dropping one of the / resulting in https://example.com/api/v3//path
    func appending(path: String) -> URL {
        
        let base = absoluteString.hasSuffix("/") ? String(absoluteString.dropLast(1)) : absoluteString
        let newPath = path.hasPrefix("/") ? String(path.dropFirst(1)) : path
        
        return URL(string: "\(base)/\(newPath)")!
    }
}

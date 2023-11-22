//
//  API.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public protocol APIRequest: Codable, Hashable {
	static var httpMethod: HTTPMethod { get }
	static var path: String { get }
    var jwt: String? { get }

	associatedtype Response: APIResponse
}

public protocol APIResponse: Codable {
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

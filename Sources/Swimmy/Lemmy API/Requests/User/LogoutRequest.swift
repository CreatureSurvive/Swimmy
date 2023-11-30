//
//  Logout.swift
//  
//
//  Created by Dana Buehre on 11/30/23.
//

import Foundation

public struct LogoutRequest: APIRequest {
    public typealias Response = SuccessResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/user/logout"
    public var jwt: String? { return nil }

    public let auth: String

    public init(auth: String) {
        self.auth = auth
    }
}

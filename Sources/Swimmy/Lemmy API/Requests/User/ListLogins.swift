//
//  ListLogins.swift
//
//
//  Created by Dana Buehre on 11/30/23.
//

import Foundation

public struct ListLoginsRequest: APIRequest {
    public typealias Response = ListLoginsResponse

    public static let httpMethod: HTTPMethod = .get
    public static let path: String = "/user/list_logins"
    public var jwt: String? { return nil }

    public let auth: String

    public init(auth: String) {
        self.auth = auth
    }
}

public typealias ListLoginsResponse = [LoginToken]
extension ListLoginsResponse: APIResponse {}

//
//  ValidateAuth.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ValidateAuthRequest: APIRequest {
    public typealias Response = SuccessResponse

    public static let httpMethod: HTTPMethod = .get
    public static let path: String = "/user/validate_auth"
    public var jwt: String? { return nil }

    public let auth: String

    public init(auth: String) {
        self.auth = auth
    }
}

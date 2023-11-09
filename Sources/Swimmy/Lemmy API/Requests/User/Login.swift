//
//  Login.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct LoginRequest: APIRequest {
	public typealias Response = LoginResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/user/login"
    public var jwt: String? { return nil }

	public let username_or_email: String
	public let password: String
    public let totp_2fa_token: String?

    public init(username_or_email: String, password: String, totp_2fa_token: String?) {
		self.username_or_email = username_or_email
		self.password = password
        self.totp_2fa_token = totp_2fa_token
	}
}
public struct LoginResponse: APIResponse {
    /// The JSON Web Token for the user.
    ///
    /// This token can be passed into `auth` parameters of other requests to make authorized requests.
    ///
    /// If you are registering a new account, this property will be `nil` if email verification is enabled, or if the server requires registration applications.
    ///
    /// It will also be `nil` if the login is wrong.
	public let jwt: String?
	public let registration_created: Bool
	public let verify_email_sent: Bool
}

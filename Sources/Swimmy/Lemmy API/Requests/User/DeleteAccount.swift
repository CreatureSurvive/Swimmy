//
//  DeleteAccount.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct DeleteAccountRequest: APIRequest {
	public typealias Response = SuccessResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/user/delete_account"
    public var jwt: String? { return auth }

	public let auth: String
	public let password: String
    public let delete_content: Bool? // v0.19 added

    public init(auth: String, password: String, delete_content: Bool? = nil) {
		self.auth = auth
		self.password = password
        self.delete_content = delete_content
	}
}

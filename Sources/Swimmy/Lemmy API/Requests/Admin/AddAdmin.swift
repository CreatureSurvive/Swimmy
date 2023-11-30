//
//  AddAdmin.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AddAdminRequest: APIRequest {
	public typealias Response = AddAdminResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/admin/add"
    public var jwt: String? { return auth }

	public let added: Bool
	public let auth: String
	public let person_id: Int? // v0.19 removed
    public let local_user_id: Int? // v0.19 added

    public init(added: Bool, auth: String, person_id: Int? = nil, local_user_id: Int? = nil) {
		self.added = added
		self.auth = auth
		self.person_id = person_id
        self.local_user_id = local_user_id
	}
}
public struct AddAdminResponse: APIResponse {
	public let admins: [PersonView]
}

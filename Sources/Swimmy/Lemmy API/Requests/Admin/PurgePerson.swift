//
//  PurgePerson.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PurgePersonRequest: APIRequest {
	public typealias Response = PurgeItemResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/admin/purge/person"
    public var jwt: String? { return auth }

	public let auth: String
	public let person_id: Int
	public let reason: String?

	public init(auth: String, person_id: Int, reason: String? = nil) {
		self.auth = auth
		self.person_id = person_id
		self.reason = reason
	}
}

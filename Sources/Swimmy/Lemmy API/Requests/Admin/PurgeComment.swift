//
//  PurgeComment.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PurgeCommentRequest: APIRequest {
	public typealias Response = PurgeItemResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/admin/purge/comment"
    public var jwt: String? { return auth }

	public let auth: String
	public let comment_id: Int
	public let reason: String?

	public init(auth: String, comment_id: Int, reason: String? = nil) {
		self.auth = auth
		self.comment_id = comment_id
		self.reason = reason
	}
}
public struct PurgeItemResponse: APIResponse {
	public let success: Bool
}

//
//  RemovePost.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct RemovePostRequest: APIRequest {
	public typealias Response = PostResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/post/remove"
    public var jwt: String? { return auth }

	public let auth: String
	public let post_id: Int
	public let reason: String?
	public let removed: Bool

	public init(auth: String, post_id: Int, reason: String? = nil, removed: Bool) {
		self.auth = auth
		self.post_id = post_id
		self.reason = reason
		self.removed = removed
	}
}

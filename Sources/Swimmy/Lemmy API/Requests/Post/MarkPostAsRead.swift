//
//  MarkPostAsRead.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct MarkPostAsReadRequest: APIRequest {
	public typealias Response = PostResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/post/mark_as_read"
    public var jwt: String? { return auth }

	public let auth: String
	public let post_id: Int? // v0.19 optional
    public let post_ids: [Int]? // v0.19 added
	public let read: Bool

    public init(auth: String, post_id: Int? = nil, post_ids: [Int]? = nil, read: Bool) {
		self.auth = auth
		self.post_id = post_id
        self.post_ids = post_ids
		self.read = read
	}
}

//
//  MarkCommentReplyAsRead.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct MarkCommentReplyAsReadRequest: APIRequest {
	public typealias Response = CommentReplyResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/comment/mark_as_read"
    public var jwt: String? { return auth }

	public let auth: String
	public let comment_reply_id: Int
	public let read: Bool

	public init(auth: String, comment_reply_id: Int, read: Bool) {
		self.auth = auth
		self.comment_reply_id = comment_reply_id
		self.read = read
	}
}

public struct CommentReplyResponse: APIResponse {
    public let comment_reply_view: CommentReplyView

    public init(comment_reply_view: CommentReplyView) {
        self.comment_reply_view = comment_reply_view
    }
}

//
//  LikeComment.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LikeCommentRequest: APIRequest {
	public typealias Response = CommentResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/comment/like"
    public var jwt: String? { return auth }

	public let auth: String
	public let comment_id: Int
	public let score: Int

	public init(auth: String, comment_id: Int, score: Int) {
		self.auth = auth
		self.comment_id = comment_id
		self.score = score
	}
}

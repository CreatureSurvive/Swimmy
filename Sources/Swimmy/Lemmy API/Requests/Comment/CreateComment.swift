//
//  CreateComment.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CreateCommentRequest: APIRequest {
    public typealias Response = CommentResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/comment"
    public var jwt: String? { return auth }

    public let auth: String
    public let content: String
    public let form_id: String?
    public let language_id: Int?
    public let parent_id: Int?
    public let post_id: Int
    
    public init(auth: String, content: String, form_id: String? = nil, language_id: Int? = nil, parent_id: Int? = nil, post_id: Int) {
        self.auth = auth
        self.content = content
        self.form_id = form_id
        self.language_id = language_id
        self.parent_id = parent_id
        self.post_id = post_id
    }
}
public struct CommentResponse: APIResponse {
	public let comment_view: CommentView
	public let form_id: String?
	public let recipient_ids: [Int]
}

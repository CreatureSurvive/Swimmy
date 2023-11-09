//
//  GetPost.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetPostRequest: APIRequest {
	public typealias Response = GetPostResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/post"
    public var jwt: String? { return auth }

	public let auth: String?
	public let comment_id: Int?
	public let id: Int?

	public init(auth: String? = nil, comment_id: Int? = nil, id: Int? = nil) {
		self.auth = auth
		self.comment_id = comment_id
		self.id = id
	}
}
public struct GetPostResponse: APIResponse {
	public let community_view: CommunityView
	public let moderators: [CommunityModeratorView]
	public let online: Int? // removed in v0.18
	public let post_view: PostView
    public let cross_posts: [PostView]?
}

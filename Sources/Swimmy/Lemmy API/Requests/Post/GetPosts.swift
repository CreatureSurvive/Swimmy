//
//  GetPosts.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetPostsRequest: APIRequest {
	public typealias Response = GetPostsResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/post/list"
    public var jwt: String? { return auth }

	public let auth: String?
	public let community_id: Int?
	/// To get posts for a federated community by name, use `name@instance.tld`.
	public let community_name: String?
	/// The maximum number of posts to retrieve.
	///
	/// It is possible that less posts will be returned if the maximum is greater than the number of posts available.
	///
	/// The server will throw a `couldnt_get_posts` error if you pass in a limit greater than 50.
	public let limit: Int?
	public let page: Int?
	public let saved_only: Bool?
    public let liked_only: Bool? // v0.19 added
    public let disliked_only: Bool? // v0.19 added
    public let show_hidden: Bool? // v0.19.4 added
    public let show_read: Bool? //v0.19.6 added
    public let show_nsfw: Bool? //v0.19.6 added
	public let sort: SortType?
	public let type_: ListingType?
    public let page_cursor: String?

    public init(auth: String? = nil, community_id: Int? = nil, community_name: String? = nil, limit: Int? = nil, page: Int? = nil, saved_only: Bool? = nil, liked_only: Bool? = nil, disliked_only: Bool? = nil, show_hidden: Bool? = nil, show_read: Bool? = nil, show_nsfw: Bool? = nil, sort: SortType? = nil, type_: ListingType? = nil, page_cursor: String? = nil) {
		self.auth = auth
		self.community_id = community_id
		self.community_name = community_name
		self.limit = limit
		self.page = page
		self.saved_only = saved_only
        self.liked_only = liked_only
        self.disliked_only = disliked_only
        self.show_hidden = show_hidden
        self.show_read = show_read
        self.show_nsfw = show_nsfw
        self.sort = sort
        self.type_ = type_
        self.page_cursor = page_cursor
	}
}
public struct GetPostsResponse: APIResponse {
	public let posts: [PostView]
    public let next_page: String?
}

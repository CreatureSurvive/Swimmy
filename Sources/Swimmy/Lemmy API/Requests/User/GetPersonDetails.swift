//
//  GetPersonDetails.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetPersonDetailsRequest: APIRequest {
	public typealias Response = GetPersonDetailsResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/user"
    public var jwt: String? { return auth }

	public let auth: String?
	public let community_id: Int?
	public let limit: Int?
	public let page: Int?
	public let person_id: Int?
	public let saved_only: Bool?
	public let sort: SortType?
	/// To get details for a federated user, use `person@instance.tld`.
	public let username: String?

	public init(auth: String? = nil, community_id: Int? = nil, limit: Int? = nil, page: Int? = nil, person_id: Int? = nil, saved_only: Bool? = nil, sort: SortType? = nil, username: String? = nil) {
		self.auth = auth
		self.community_id = community_id
		self.limit = limit
		self.page = page
		self.person_id = person_id
		self.saved_only = saved_only
		self.sort = sort
		self.username = username
	}
}
public struct GetPersonDetailsResponse: APIResponse {
	public var comments: [CommentView]
	public var moderates: [CommunityModeratorView]
	public var person_view: PersonView
	public var posts: [PostView]
}

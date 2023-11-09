//
//  GetCommunity.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetCommunityRequest: APIRequest {
	public typealias Response = GetCommunityResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/community"
    public var jwt: String? { return auth }

	public let auth: String?
	public let id: Int?
	public let name: String?

	public init(auth: String? = nil, id: Int? = nil, name: String? = nil) {
		self.auth = auth
		self.id = id
		self.name = name
	}
}
public struct GetCommunityResponse: APIResponse {
	public let community_view: CommunityView
	public let default_post_language: Int?
	public let discussion_languages: [Int]
	public let moderators: [CommunityModeratorView]
	public let online: Int? // v0.18 removed
	public let site: Site?
}

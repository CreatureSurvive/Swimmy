//
//  ListCommunities.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ListCommunitiesRequest: APIRequest {
	public typealias Response = ListCommunitiesResponse
	
	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/community/list"
    public var jwt: String? { return auth }
	
	public let auth: String?
	public let limit: Int?
	public let page: Int?
	public let sort: SortType?
	public let type_: ListingType?
	
	public init(auth: String? = nil, limit: Int? = nil, page: Int? = nil, sort: SortType? = nil, type_: ListingType? = nil) {
		self.auth = auth
		self.limit = limit
		self.page = page
		self.sort = sort
		self.type_ = type_
	}
}
public struct ListCommunitiesResponse: APIResponse {
	public let communities: [CommunityView]
}

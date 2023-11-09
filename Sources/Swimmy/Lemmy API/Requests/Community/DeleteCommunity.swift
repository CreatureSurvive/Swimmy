//
//  DeleteCommunity.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct DeleteCommunityRequest: APIRequest {
	public typealias Response = CommunityResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/community/delete"
    public var jwt: String? { return auth }

	public let auth: String
	public let community_id: Int
	public let deleted: Bool

	public init(auth: String, community_id: Int, deleted: Bool) {
		self.auth = auth
		self.community_id = community_id
		self.deleted = deleted
	}
}

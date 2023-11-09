//
//  BlockCommunity.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct BlockCommunityRequest: APIRequest {
	public typealias Response = BlockCommunityResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/community/block"
    public var jwt: String? { return auth }

	public let auth: String
	public let block: Bool
	public let community_id: Int

	public init(auth: String, block: Bool, community_id: Int) {
		self.auth = auth
		self.block = block
		self.community_id = community_id
	}
}
public struct BlockCommunityResponse: APIResponse {
	public let blocked: Bool
	public let community_view: CommunityView
}

public struct HideCommunityRequest: APIRequest {
    public typealias Response = HideCommunityResponse
    
    public static let httpMethod: HTTPMethod = .put
    public static let path: String = "/community/hide"
    public var jwt: String? { return auth }

    let community_id: Int

    let hidden: Bool
    let reason: String?

    let auth: String

    public init(auth: String, community_id: Int, hidden: Bool, reason: String?) {
        
        self.auth = auth
        self.community_id = community_id
        self.hidden = hidden
        self.reason = reason
    }
}

public struct HideCommunityResponse: APIResponse {
    let communityView: CommunityView
    let discussionLanguages: [Int]
}

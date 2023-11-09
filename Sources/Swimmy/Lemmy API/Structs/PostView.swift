//
//  PostView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PostView: Codable, Hashable {
	public let community: Community
	public let counts: PostAggregates
	public var creator: Person
	public var creator_banned_from_community: Bool
	public let creator_blocked: Bool
	public let my_vote: Int?
	public let post: Post
	public var read: Bool
	public var saved: Bool
	public var subscribed: SubscribedType
	public let unread_comments: Int
}

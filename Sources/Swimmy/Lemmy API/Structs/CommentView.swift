//
//  CommentView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct CommentView: Codable, Hashable {
	public let comment: Comment
	public let community: Community
	public let counts: CommentAggregates
	public var creator: Person
	public var creator_banned_from_community: Bool
	public let creator_blocked: Bool
	public let my_vote: Int?
	public let post: Post
	public let saved: Bool
	public let subscribed: SubscribedType
}

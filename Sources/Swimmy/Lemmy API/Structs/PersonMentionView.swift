//
//  PersonMentionView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PersonMentionView: Codable, Hashable {
	public let comment: Comment
	public let community: Community
	public let counts: CommentAggregates
	public let creator: Person
	public let creator_banned_from_community: Bool
	public let creator_blocked: Bool
	public let my_vote: Int?
	public let person_mention: PersonMention
	public let post: Post
	public let recipient: Person
	public let saved: Bool
	public let subscribed: SubscribedType
}

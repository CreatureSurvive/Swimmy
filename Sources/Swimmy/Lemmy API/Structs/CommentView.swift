//
//  CommentView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct CommentView: Codable, Hashable, Sendable {
    public let comment: Comment
    public let community: Community
    public let counts: CommentAggregates
    public var creator: Person
    public var creator_banned_from_community: Bool
    public let creator_is_admin: Bool? // v0.19 added
    public let creator_blocked: Bool
    public let my_vote: Int?
    public let post: Post
    public let saved: Bool
    public let subscribed: SubscribedType
    
    public init(comment: Comment, community: Community, counts: CommentAggregates, creator: Person, creator_banned_from_community: Bool, creator_is_admin: Bool? = nil, creator_blocked: Bool, my_vote: Int? = nil, post: Post, saved: Bool, subscribed: SubscribedType) {
        self.comment = comment
        self.community = community
        self.counts = counts
        self.creator = creator
        self.creator_banned_from_community = creator_banned_from_community
        self.creator_is_admin = creator_is_admin
        self.creator_blocked = creator_blocked
        self.my_vote = my_vote
        self.post = post
        self.saved = saved
        self.subscribed = subscribed
    }
}

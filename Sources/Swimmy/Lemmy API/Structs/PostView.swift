//
//  PostView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PostView: Codable, Hashable, Sendable {
    public let community: Community
    public let counts: PostAggregates
    public var creator: Person
    public var creator_banned_from_community: Bool
    public let creator_is_moderator: Bool? //v0.19 added
    public let creator_is_admin: Bool? // v0.19 added
    public let creator_blocked: Bool
    public let my_vote: Int?
    public let post: Post
    public let hidden: Bool? // v0.19.4 added
    public var read: Bool
    public var saved: Bool
    public var subscribed: SubscribedType
    public let unread_comments: Int
    public let image_details: ImageDetails? // v0.19.6 added
    
    public init(community: Community, counts: PostAggregates, creator: Person, creator_banned_from_community: Bool, creator_is_moderator: Bool? = nil, creator_is_admin: Bool? = nil, creator_blocked: Bool, my_vote: Int? = nil, post: Post, read: Bool, hidden: Bool? = nil, saved: Bool, subscribed: SubscribedType, unread_comments: Int, image_details: ImageDetails? = nil) {
        self.community = community
        self.counts = counts
        self.creator = creator
        self.creator_banned_from_community = creator_banned_from_community
        self.creator_is_moderator = creator_is_moderator
        self.creator_is_admin = creator_is_admin
        self.creator_blocked = creator_blocked
        self.my_vote = my_vote
        self.post = post
        self.hidden = hidden
        self.read = read
        self.saved = saved
        self.subscribed = subscribed
        self.unread_comments = unread_comments
        self.image_details = image_details
    }
}

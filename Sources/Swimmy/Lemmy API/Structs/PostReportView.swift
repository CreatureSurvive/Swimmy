//
//  PostReportView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PostReportView: Codable, Hashable {
    public let community: Community
    public let counts: PostAggregates
    public let creator: Person
    public var creator_banned_from_community: Bool
    public let my_vote: Int?
    public var post: Post
    public var post_creator: Person
    public let post_report: PostReport
    public let resolver: Person?
    
    public init(community: Community, counts: PostAggregates, creator: Person, creator_banned_from_community: Bool, my_vote: Int? = nil, post: Post, post_creator: Person, post_report: PostReport, resolver: Person? = nil) {
        self.community = community
        self.counts = counts
        self.creator = creator
        self.creator_banned_from_community = creator_banned_from_community
        self.my_vote = my_vote
        self.post = post
        self.post_creator = post_creator
        self.post_report = post_report
        self.resolver = resolver
    }
}

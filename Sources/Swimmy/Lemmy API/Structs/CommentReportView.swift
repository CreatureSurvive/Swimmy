//
//  CommentReportView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommentReportView: Codable, Hashable, Sendable {
    public var comment: Comment
    public var comment_creator: Person
    public let comment_report: CommentReport
    public let community: Community
    public let counts: CommentAggregates
    public let creator: Person
    public var creator_banned_from_community: Bool
    public let my_vote: Int?
    public let post: Post
    public let resolver: Person?
    
    public init(comment: Comment, comment_creator: Person, comment_report: CommentReport, community: Community, counts: CommentAggregates, creator: Person, creator_banned_from_community: Bool, my_vote: Int? = nil, post: Post, resolver: Person? = nil) {
        self.comment = comment
        self.comment_creator = comment_creator
        self.comment_report = comment_report
        self.community = community
        self.counts = counts
        self.creator = creator
        self.creator_banned_from_community = creator_banned_from_community
        self.my_vote = my_vote
        self.post = post
        self.resolver = resolver
    }
}

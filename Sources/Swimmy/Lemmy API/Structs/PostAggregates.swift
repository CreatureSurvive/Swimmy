//
//  PostAggregates.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PostAggregates: Codable, Identifiable, Hashable {
    public let comments: Int
    public let downvotes: Int
    public let featured_community: Bool? // v0.19 removed
    public let featured_local: Bool? // v0.19 removed
    public let id: Int? // v0.19 removed
    public let newest_comment_time: String? // v0.19 removed
    /// Newest comment time, limited to 2 days, to prevent necrobumping.
    public let newest_comment_time_necro: String? // v0.19 removed
    public let post_id: Int
    public let score: Int
    public let upvotes: Int
    
    public init(comments: Int, downvotes: Int, featured_community: Bool? = nil, featured_local: Bool? = nil, id: Int?, newest_comment_time: String? = nil, newest_comment_time_necro: String? = nil, post_id: Int, score: Int, upvotes: Int) {
        self.comments = comments
        self.downvotes = downvotes
        self.featured_community = featured_community
        self.featured_local = featured_local
        self.id = id
        self.newest_comment_time = newest_comment_time
        self.newest_comment_time_necro = newest_comment_time_necro
        self.post_id = post_id
        self.score = score
        self.upvotes = upvotes
    }
}

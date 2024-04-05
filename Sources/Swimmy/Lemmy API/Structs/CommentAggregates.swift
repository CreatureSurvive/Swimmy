//
//  CommentAggregates.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct CommentAggregates: Codable, Identifiable, Hashable, Sendable {
    public let child_count: Int
    public let comment_id: Int
    public let downvotes: Int
    public let id: Int? // v0.19 removed
    public let score: Int
    public let upvotes: Int
    public let creator_is_admin: Bool? // v0.19 added

    public init(child_count: Int, comment_id: Int, downvotes: Int, id: Int?, score: Int, upvotes: Int, creator_is_admin: Bool? = nil) {
        self.child_count = child_count
        self.comment_id = comment_id
        self.downvotes = downvotes
        self.id = id
        self.score = score
        self.upvotes = upvotes
        self.creator_is_admin = creator_is_admin
    }
}

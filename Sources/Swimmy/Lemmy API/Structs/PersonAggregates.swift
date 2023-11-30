//
//  PersonAggregates.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PersonAggregates: Codable, Identifiable, Hashable {
    public let comment_count: Int
    public let comment_score: Int? // v0.19 removed
    public let id: Int? // v0.19 removed
    public let person_id: Int
    public let post_count: Int
    public let post_score: Int? // v0.19 removed

    public init(comment_count: Int, comment_score: Int? = nil, id: Int?, person_id: Int, post_count: Int, post_score: Int? = nil) {
        self.comment_count = comment_count
        self.comment_score = comment_score
        self.id = id
        self.person_id = person_id
        self.post_count = post_count
        self.post_score = post_score
    }
}

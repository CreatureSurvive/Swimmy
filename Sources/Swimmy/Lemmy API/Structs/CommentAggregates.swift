//
//  CommentAggregates.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct CommentAggregates: Codable, Identifiable, Hashable {
	public let child_count: Int
	public let comment_id: Int
	public let downvotes: Int
	public let id: Int
	public let score: Int
	public let upvotes: Int
}

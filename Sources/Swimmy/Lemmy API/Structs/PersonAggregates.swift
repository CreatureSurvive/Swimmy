//
//  PersonAggregates.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PersonAggregates: Codable, Identifiable, Hashable {
	public let comment_count: Int
	public let comment_score: Int
	public let id: Int
	public let person_id: Int
	public let post_count: Int
	public let post_score: Int
}

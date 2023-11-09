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
}

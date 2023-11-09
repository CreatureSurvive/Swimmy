//
//  CommentReportView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommentReportView: Codable, Hashable {
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
}

//
//  AdminPurgeCommentView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AdminPurgeCommentView: Codable, Hashable {
	public let admin: Person?
	public let admin_purge_comment: AdminPurgeComment
	public let post: Post
}

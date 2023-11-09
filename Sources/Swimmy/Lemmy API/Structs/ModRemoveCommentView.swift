//
//  ModRemoveCommentView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemoveCommentView: Codable, Hashable {
	public let comment: Comment
	public let commenter: Person
	public let community: Community
	public let mod_remove_comment: ModRemoveComment
	public let moderator: Person?
	public let post: Post
}

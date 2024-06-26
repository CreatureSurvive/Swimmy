//
//  ModRemoveCommentView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemoveCommentView: Codable, Hashable, Sendable {
    public let comment: Comment
    public let commenter: Person
    public let community: Community
    public let mod_remove_comment: ModRemoveComment
    public let moderator: Person?
    public let post: Post

    public init(comment: Comment, commenter: Person, community: Community, mod_remove_comment: ModRemoveComment, moderator: Person? = nil, post: Post) {
        self.comment = comment
        self.commenter = commenter
        self.community = community
        self.mod_remove_comment = mod_remove_comment
        self.moderator = moderator
        self.post = post
    }
}

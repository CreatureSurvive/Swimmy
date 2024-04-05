//
//  ModLockPostView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModLockPostView: Codable, Hashable, Sendable {
    public let community: Community
    public let mod_lock_post: ModLockPost
    public let moderator: Person?
    public let post: Post

    public init(community: Community, mod_lock_post: ModLockPost, moderator: Person? = nil, post: Post) {
        self.community = community
        self.mod_lock_post = mod_lock_post
        self.moderator = moderator
        self.post = post
    }
}

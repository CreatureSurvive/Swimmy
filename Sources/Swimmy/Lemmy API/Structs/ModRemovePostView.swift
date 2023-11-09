//
//  ModRemovePostView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemovePostView: Codable, Hashable {
    public let community: Community
    public let mod_remove_post: ModRemovePost
    public let moderator: Person?
    public let post: Post

    public init(community: Community, mod_remove_post: ModRemovePost, moderator: Person? = nil, post: Post) {
        self.community = community
        self.mod_remove_post = mod_remove_post
        self.moderator = moderator
        self.post = post
    }
}

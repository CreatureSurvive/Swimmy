//
//  ModFeaturePostView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModFeaturePostView: Codable, Hashable {
    public let community: Community
    public let mod_feature_post: ModFeaturePost
    public let moderator: Person?
    public let post: Post

    public init(community: Community, mod_feature_post: ModFeaturePost, moderator: Person? = nil, post: Post) {
        self.community = community
        self.mod_feature_post = mod_feature_post
        self.moderator = moderator
        self.post = post
    }
}

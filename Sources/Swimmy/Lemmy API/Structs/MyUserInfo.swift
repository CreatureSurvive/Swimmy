//
//  MyUserInfo.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct MyUserInfo: Codable, Hashable, Sendable {
    public let community_blocks: [CommunityBlockView]
    public let discussion_languages: [Int]
    public let follows: [CommunityFollowerView]
    public let local_user_view: LocalUserSettingsView
    public let moderates: [CommunityModeratorView]
    public let instance_blocks: [InstanceBlockView]? // v0.1.9
    public let person_blocks: [PersonBlockView]

    public init(community_blocks: [CommunityBlockView], discussion_languages: [Int], follows: [CommunityFollowerView], local_user_view: LocalUserSettingsView, moderates: [CommunityModeratorView], instance_blocks: [InstanceBlockView]? = nil, person_blocks: [PersonBlockView]) {
        self.community_blocks = community_blocks
        self.discussion_languages = discussion_languages
        self.follows = follows
        self.local_user_view = local_user_view
        self.moderates = moderates
        self.instance_blocks = instance_blocks
        self.person_blocks = person_blocks
    }
}

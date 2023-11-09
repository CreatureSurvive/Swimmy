//
//  MyUserInfo.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct MyUserInfo: Codable, Hashable {
	public let community_blocks: [CommunityBlockView]
	public let discussion_languages: [Int]
	public let follows: [CommunityFollowerView]
	public let local_user_view: LocalUserSettingsView
	public let moderates: [CommunityModeratorView]
    public let instance_blocks: [InstanceBlockView]? // v0.1.9
	public let person_blocks: [PersonBlockView]
}

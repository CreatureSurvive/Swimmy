//
//  ModRemoveCommunityView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemoveCommunityView: Codable, Hashable, Sendable {
    public let community: Community
    public let mod_remove_community: ModRemoveCommunity
    public let moderator: Person?

    public init(community: Community, mod_remove_community: ModRemoveCommunity, moderator: Person? = nil) {
        self.community = community
        self.mod_remove_community = mod_remove_community
        self.moderator = moderator
    }
}

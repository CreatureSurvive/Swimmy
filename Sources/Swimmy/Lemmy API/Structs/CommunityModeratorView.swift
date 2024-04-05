//
//  CommunityModeratorView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommunityModeratorView: Codable, Hashable, Sendable {
    public let community: Community
    public let moderator: Person

    public init(community: Community, moderator: Person) {
        self.community = community
        self.moderator = moderator
    }
}

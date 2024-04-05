//
//  CommunityFollowerView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommunityFollowerView: Codable, Hashable, Sendable {
    public let community: Community
    public let follower: Person

    public init(community: Community, follower: Person) {
        self.community = community
        self.follower = follower
    }
}

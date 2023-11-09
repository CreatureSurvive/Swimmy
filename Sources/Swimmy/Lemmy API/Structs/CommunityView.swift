//
//  CommunityView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct CommunityView: Codable, Hashable {
    public let blocked: Bool
    public let community: Community
    public let counts: CommunityAggregates
    public let subscribed: SubscribedType

    public init(blocked: Bool, community: Community, counts: CommunityAggregates, subscribed: SubscribedType) {
        self.blocked = blocked
        self.community = community
        self.counts = counts
        self.subscribed = subscribed
    }
}

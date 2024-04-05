//
//  AdminPurgeCommunityView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AdminPurgeCommunityView: Codable, Hashable, Sendable {
    public let admin: Person?
    public let admin_purge_community: AdminPurgeCommunity
    
    public init(admin: Person? = nil, admin_purge_community: AdminPurgeCommunity) {
        self.admin = admin
        self.admin_purge_community = admin_purge_community
    }
}

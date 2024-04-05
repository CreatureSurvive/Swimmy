//
//  SiteAggregates.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct SiteAggregates: Codable, Identifiable, Hashable, Sendable {
    public let comments: Int
    public let communities: Int
    public let id: Int? // v0.19 removed
    public let posts: Int
    public let site_id: Int
    public let users: Int
    public let users_active_day: Int
    public let users_active_half_year: Int
    public let users_active_month: Int
    public let users_active_week: Int
    
    public init(comments: Int, communities: Int, id: Int?, posts: Int, site_id: Int, users: Int, users_active_day: Int, users_active_half_year: Int, users_active_month: Int, users_active_week: Int) {
        self.comments = comments
        self.communities = communities
        self.id = id
        self.posts = posts
        self.site_id = site_id
        self.users = users
        self.users_active_day = users_active_day
        self.users_active_half_year = users_active_half_year
        self.users_active_month = users_active_month
        self.users_active_week = users_active_week
    }
}

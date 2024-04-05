//
//  LocalSiteRateLimit.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LocalSiteRateLimit: Codable, Identifiable, Hashable, Sendable {
    public let comment: Int
    public let comment_per_second: Int
    public let id: Int? // v0.19 removed
    public let image: Int
    public let image_per_second: Int
    public let local_site_id: Int
    public let message: Int
    public let message_per_second: Int
    public let post: Int
    public let post_per_second: Int
    public let published: String
    public let register: Int
    public let register_per_second: Int
    public let search: Int
    public let search_per_second: Int
    public let updated: String?
    public let import_user_settings: Int?
    public let import_user_settings_per_second: Int?
    
    public init(comment: Int, comment_per_second: Int, id: Int?, image: Int, image_per_second: Int, local_site_id: Int, message: Int, message_per_second: Int, post: Int, post_per_second: Int, published: String, register: Int, register_per_second: Int, search: Int, search_per_second: Int, updated: String? = nil, import_user_settings: Int? = nil, import_user_settings_per_second: Int? = nil) {
        self.comment = comment
        self.comment_per_second = comment_per_second
        self.id = id
        self.image = image
        self.image_per_second = image_per_second
        self.local_site_id = local_site_id
        self.message = message
        self.message_per_second = message_per_second
        self.post = post
        self.post_per_second = post_per_second
        self.published = published
        self.register = register
        self.register_per_second = register_per_second
        self.search = search
        self.search_per_second = search_per_second
        self.updated = updated
        self.import_user_settings = import_user_settings
        self.import_user_settings_per_second = import_user_settings_per_second
    }
}

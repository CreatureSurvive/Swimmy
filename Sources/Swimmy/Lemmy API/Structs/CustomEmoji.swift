//
//  CustomEmoji.swift
//  Swimmy
//
//  Created by Dana Buehre on 1/29/25.
//


import Foundation

public struct CustomEmoji: Codable, Identifiable, Hashable, Sendable {
    public let id: Int
    public let alt_text: String
    public let category: String
    public let image_url: String
    public let local_site_id: Int
    public let published: String
    public let shortcode: String
    public let updated: String?

    public init(id: Int, alt_text: String, category: String, image_url: String, local_site_id: Int, published: String, shortcode: String, updated: String? = nil) {
        self.id = id
        self.alt_text = alt_text
        self.category = category
        self.image_url = image_url
        self.local_site_id = local_site_id
        self.published = published
        self.shortcode = shortcode
        self.updated = updated
    }
}
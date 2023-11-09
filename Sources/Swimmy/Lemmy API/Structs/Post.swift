//
//  Post.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct Post: Codable, Identifiable, Hashable, Equatable {
    public let ap_id: String
    public let body: String?
    public let community_id: Int
    public let creator_id: Int
    public let deleted: Bool
    public let embed_description: String?
    public let embed_title: String?
    public let embed_video_url: URL?
    public let featured_community: Bool
    public let featured_local: Bool
    public let id: Int
    public let language_id: Int
    public let local: Bool
    public let locked: Bool
    public let name: String
    public let nsfw: Bool
    public let published: String
    public let removed: Bool
    public let thumbnail_url: URL?
    public let updated: String?
    public let url: String?
    
    static public func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(ap_id: String, body: String? = nil, community_id: Int, creator_id: Int, deleted: Bool, embed_description: String? = nil, embed_title: String? = nil, embed_video_url: URL? = nil, featured_community: Bool, featured_local: Bool, id: Int, language_id: Int, local: Bool, locked: Bool, name: String, nsfw: Bool, published: String, removed: Bool, thumbnail_url: URL? = nil, updated: String? = nil, url: String? = nil) {
        self.ap_id = ap_id
        self.body = body
        self.community_id = community_id
        self.creator_id = creator_id
        self.deleted = deleted
        self.embed_description = embed_description
        self.embed_title = embed_title
        self.embed_video_url = embed_video_url
        self.featured_community = featured_community
        self.featured_local = featured_local
        self.id = id
        self.language_id = language_id
        self.local = local
        self.locked = locked
        self.name = name
        self.nsfw = nsfw
        self.published = published
        self.removed = removed
        self.thumbnail_url = thumbnail_url
        self.updated = updated
        self.url = url
    }
}

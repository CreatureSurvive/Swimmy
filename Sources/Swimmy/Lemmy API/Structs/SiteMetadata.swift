//
//  SiteMetadata.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct SiteMetadata: Codable, Hashable, Sendable {
    public let description: String?
    public let html: String?
    public let image: String?
    public let title: String?
    public let embed_video_url: String?

    public init(description: String? = nil, html: String? = nil, image: String? = nil, title: String? = nil, embed_video_url: String? = nil) {
        self.description = description
        self.html = html
        self.image = image
        self.title = title
        self.embed_video_url = embed_video_url
    }
}

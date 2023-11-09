//
//  SiteMetadata.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct SiteMetadata: Codable, Hashable {
	public let description: String?
	public let html: String?
	public let image: String?
	public let title: String?
    public let embed_video_url: String?
}

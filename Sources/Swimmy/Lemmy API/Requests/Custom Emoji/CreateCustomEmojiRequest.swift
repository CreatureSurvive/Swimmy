//
//  CreateCustomEmojiRequest.swift
//  Swimmy
//
//  Created by Dana Buehre on 1/29/25.
//

import Foundation

public struct CreateCustomEmojiRequest: APIRequest {
    public typealias Response = CustomEmojiResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/custom_emoji"
    public var jwt: String? { return auth }

    public let auth: String
    public let alt_text: String
    public let category: String
    public let image_url: String
    public let keywords: [String]
    public let shortcode: String

    public init(auth: String, alt_text: String, category: String, image_url: String, keywords: [String], shortcode: String) {
        self.auth = auth
        self.alt_text = alt_text
        self.category = category
        self.image_url = image_url
        self.keywords = keywords
        self.shortcode = shortcode
    }
}

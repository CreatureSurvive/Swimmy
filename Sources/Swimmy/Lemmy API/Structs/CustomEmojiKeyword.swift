//
//  CustomEmojiKeyword.swift
//  Swimmy
//
//  Created by Dana Buehre on 1/29/25.
//


import Foundation

public struct CustomEmojiKeyword: Codable, Hashable, Sendable {
    public let custom_emoji_id: Int
    public let keyword: String

    public init(custom_emoji_id: Int, keyword: String) {
        self.custom_emoji_id = custom_emoji_id
        self.keyword = keyword
    }
}

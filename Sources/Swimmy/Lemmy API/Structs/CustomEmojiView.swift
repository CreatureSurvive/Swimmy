//
//  CustomEmojiView.swift
//  Swimmy
//
//  Created by Dana Buehre on 1/29/25.
//


import Foundation

public struct CustomEmojiView: Codable, Hashable, Sendable {
    public let custom_emoji: CustomEmoji
    public let keywords: [CustomEmojiKeyword]

    public init(custom_emoji: CustomEmoji, keywords: [CustomEmojiKeyword]) {
        self.custom_emoji = custom_emoji
        self.keywords = keywords
    }
}
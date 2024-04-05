//
//  PersonMention.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PersonMention: Codable, Identifiable, Hashable, Sendable {
    public let comment_id: Int
    public let id: Int
    public let published: String
    public var read: Bool
    public let recipient_id: Int
    
    public init(comment_id: Int, id: Int, published: String, read: Bool, recipient_id: Int) {
        self.comment_id = comment_id
        self.id = id
        self.published = published
        self.read = read
        self.recipient_id = recipient_id
    }
}

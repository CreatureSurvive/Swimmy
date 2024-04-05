//
//  PrivateMessageView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PrivateMessageView: Codable, Hashable, Sendable {
    public let creator: Person
    public var private_message: PrivateMessage
    public let recipient: Person

    public init(creator: Person, private_message: PrivateMessage, recipient: Person) {
        self.creator = creator
        self.private_message = private_message
        self.recipient = recipient
    }
}

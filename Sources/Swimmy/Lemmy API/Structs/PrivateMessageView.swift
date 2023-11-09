//
//  PrivateMessageView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PrivateMessageView: Codable, Hashable {
	public let creator: Person
	public var private_message: PrivateMessage
	public let recipient: Person
}

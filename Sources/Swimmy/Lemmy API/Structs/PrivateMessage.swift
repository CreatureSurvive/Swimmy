//
//  PrivateMessage.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PrivateMessage: Codable, Identifiable, Hashable {
	public let ap_id: String
	public let content: String
	public let creator_id: Int
	public let deleted: Bool
	public let id: Int
	public let local: Bool
	public let published: String
	public var read: Bool
	public let recipient_id: Int
	public let updated: String?
}

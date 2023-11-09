//
//  Person.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct Person: Codable, Identifiable, Hashable {
	public let actor_id: String
	public let admin: Bool? // v0.19 change to optional
	public let avatar: String?
	public let ban_expires: String?
	public var banned: Bool
	public let banner: String?
	public let bio: String?
	public let bot_account: Bool
	public let deleted: Bool
	public let display_name: String?
	public let id: Int
	public let inbox_url: String?
	public let instance_id: Int
	public let local: Bool
	public let matrix_user_id: String?
	public let name: String
	public let published: String
	public let shared_inbox_url: String?
	public let updated: String?
}

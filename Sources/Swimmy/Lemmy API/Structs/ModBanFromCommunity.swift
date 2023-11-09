//
//  ModBanFromCommunity.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModBanFromCommunity: Codable, Identifiable, Hashable {
	public let banned: Bool?
	public let community_id: Int
	public let expires: String?
	public let id: Int
	public let mod_person_id: Int
	public let other_person_id: Int
	public let reason: String?
	public let when_: String
}

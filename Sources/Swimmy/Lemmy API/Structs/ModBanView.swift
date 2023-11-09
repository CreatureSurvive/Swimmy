//
//  ModBanView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModBanView: Codable, Hashable {
	public let banned_person: Person
	public let mod_ban: ModBan
	public let moderator: Person?
}

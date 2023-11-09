//
//  ModAdd.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModAdd: Codable, Identifiable, Hashable {
	public let id: Int
	public let mod_person_id: Int
	public let other_person_id: Int
	public let removed: Bool?
	public let when_: String
}

//
//  ModAddView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModAddView: Codable, Hashable {
	public let mod_add: ModAdd
	public let modded_person: Person
	public let moderator: Person?
}

//
//  ModAddView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModAddView: Codable, Hashable, Sendable {
    public let mod_add: ModAdd
    public let modded_person: Person
    public let moderator: Person?

    public init(mod_add: ModAdd, modded_person: Person, moderator: Person? = nil) {
        self.mod_add = mod_add
        self.modded_person = modded_person
        self.moderator = moderator
    }
}

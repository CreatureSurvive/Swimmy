//
//  PersonView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PersonView: Codable, Hashable, Sendable {
    public let counts: PersonAggregates
    public let person: Person
    public let is_admin: Bool? // v0.19 added

    public init(counts: PersonAggregates, person: Person, is_admin: Bool? = nil) {
        self.counts = counts
        self.person = person
        self.is_admin = is_admin
    }
}

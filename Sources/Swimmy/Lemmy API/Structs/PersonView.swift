//
//  PersonView.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public struct PersonView: Codable, Hashable {
    public let counts: PersonAggregates
    public let person: Person

    public init(counts: PersonAggregates, person: Person) {
        self.counts = counts
        self.person = person
    }
}

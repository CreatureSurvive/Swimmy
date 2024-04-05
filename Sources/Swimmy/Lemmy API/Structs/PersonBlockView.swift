//
//  PersonBlockView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PersonBlockView: Codable, Hashable, Sendable {
    public let person: Person
    public let target: Person

    public init(person: Person, target: Person) {
        self.person = person
        self.target = target
    }
}

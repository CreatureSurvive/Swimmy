//
//  InstanceBlockView.swift
//  Arctic
//
//  Created by Dana Buehre on 10/3/23.
//

import Foundation

public struct InstanceBlockView: Codable, Hashable, Sendable {
    public let person: Person
    public let instance: Instance
    public let site: Site?

    public init(person: Person, instance: Instance, site: Site? = nil) {
        self.person = person
        self.instance = instance
        self.site = site
    }
}

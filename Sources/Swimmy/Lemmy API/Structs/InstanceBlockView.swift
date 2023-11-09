//
//  InstanceBlockView.swift
//  Arctic
//
//  Created by Dana Buehre on 10/3/23.
//

import Foundation

public struct InstanceBlockView: Codable, Hashable {
    public let person: Person
    public let instance: Instance
    public let site: Site?
}

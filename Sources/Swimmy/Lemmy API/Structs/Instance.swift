//
//  Instance.swift
//  Arctic
//
//  Created by Dana Buehre on 9/4/23.
//

import Foundation

public struct Instance: Codable, Identifiable, Hashable {
    public let id: Int
    public let domain: String
    public let published: String
    public let updated: String?
    public let software: String?
    public let version: String?
}

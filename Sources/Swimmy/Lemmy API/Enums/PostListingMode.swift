//
//  File.swift
//  
//
//  Created by Dana Buehre on 11/30/23.
//

import Foundation

public enum PostListingMode: String, Codable, CustomStringConvertible, CaseIterable, Sendable {
    case list = "List"
    case card = "Card"
    case smallcard = "SmallCard"

    public var description: String {
        return self.rawValue
    }
}

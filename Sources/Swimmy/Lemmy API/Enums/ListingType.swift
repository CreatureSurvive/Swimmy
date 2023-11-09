//
//  ListingType.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

public enum ListingType: String, Codable, CustomStringConvertible, CaseIterable {
	case all = "All"
	case community = "Community" // this is invalid
	case local = "Local"
	case subscribed = "Subscribed"

	public var description: String {
		return self.rawValue
	}
    
    public static var allTypes: [ListingType] {
        return [.all, local, .subscribed]
    }
}

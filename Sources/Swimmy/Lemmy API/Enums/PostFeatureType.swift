//
//  PostFeatureType.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public enum PostFeatureType: String, Codable, CustomStringConvertible, CaseIterable, Sendable {
	case community = "Community"
	case local = "Local"

	public var description: String {
		return self.rawValue
	}
}

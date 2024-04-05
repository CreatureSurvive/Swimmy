//
//  RegistrationMode.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public enum RegistrationMode: String, Codable, CustomStringConvertible, CaseIterable, Sendable {
	case closed = "Closed"
	case open = "Open"
	case requireApplication = "RequireApplication"

	public var description: String {
		return self.rawValue
	}
}

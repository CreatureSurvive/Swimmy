//
//  LocalUserSettingsView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LocalUserSettingsView: Codable, Hashable {
	public let counts: PersonAggregates
	public let local_user: LocalUserSettings
	public let person: Person
}

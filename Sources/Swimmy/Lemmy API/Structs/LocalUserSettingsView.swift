//
//  LocalUserSettingsView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LocalUserSettingsView: Codable, Hashable, Sendable {
    public let counts: PersonAggregates
    public let local_user: LocalUserSettings
    public let person: Person

    public init(counts: PersonAggregates, local_user: LocalUserSettings, person: Person) {
        self.counts = counts
        self.local_user = local_user
        self.person = person
    }
}

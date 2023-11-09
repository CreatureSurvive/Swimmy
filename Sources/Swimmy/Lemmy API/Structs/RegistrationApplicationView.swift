//
//  RegistrationApplicationView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct RegistrationApplicationView: Codable, Hashable {
	public let admin: Person?
	public let creator: Person
	public let creator_local_user: LocalUserSettings
	public let registration_application: RegistrationApplication
}

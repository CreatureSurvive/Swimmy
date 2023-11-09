//
//  AdminPurgePerson.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AdminPurgePerson: Codable, Identifiable, Hashable {
	public let admin_person_id: Int
	public let id: Int
	public let reason: String?
	public let when_: String
}

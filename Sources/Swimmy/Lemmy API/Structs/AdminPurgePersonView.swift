//
//  AdminPurgePersonView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AdminPurgePersonView: Codable, Hashable {
	public let admin: Person?
	public let admin_purge_person: AdminPurgePerson
}

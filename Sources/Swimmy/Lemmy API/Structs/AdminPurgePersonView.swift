//
//  AdminPurgePersonView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct AdminPurgePersonView: Codable, Hashable, Sendable {    
    public let admin: Person?
    public let admin_purge_person: AdminPurgePerson

    public init(admin: Person? = nil, admin_purge_person: AdminPurgePerson) {
        self.admin = admin
        self.admin_purge_person = admin_purge_person
    }
}

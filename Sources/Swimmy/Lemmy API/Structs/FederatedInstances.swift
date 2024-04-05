//
//  FederatedInstances.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct FederatedInstances: Codable, Hashable, Sendable {
    public let allowed: [Instance]?
    public let blocked: [Instance]?
    public let linked: [Instance]

    public init(allowed: [Instance]? = nil, blocked: [Instance]? = nil, linked: [Instance]) {
        self.allowed = allowed
        self.blocked = blocked
        self.linked = linked
    }
}

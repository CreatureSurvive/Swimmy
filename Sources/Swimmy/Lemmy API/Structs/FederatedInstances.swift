//
//  FederatedInstances.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct FederatedInstances: Codable, Hashable {
	public let allowed: [Instance]?
	public let blocked: [Instance]?
	public let linked: [Instance]
}

//
//  Language.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct Language: Codable, Identifiable, Hashable {
	public let code: String
	public let id: Int
	public let name: String
}

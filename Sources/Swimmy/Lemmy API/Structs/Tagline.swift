//
//  Tagline.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct Tagline: Codable, Identifiable, Hashable {
	public let content: String
	public let id: Int
	public let local_site_id: Int
	public let published: String
	public let updated: String?
}

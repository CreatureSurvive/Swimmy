//
//  ModAddCommunityView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModAddCommunityView: Codable, Hashable {
	public let community: Community
	public let mod_add_community: ModAddCommunity
	public let modded_person: Person
	public let moderator: Person
}

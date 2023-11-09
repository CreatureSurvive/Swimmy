//
//  ModRemoveCommunityView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemoveCommunityView: Codable, Hashable {
	public let community: Community
	public let mod_remove_community: ModRemoveCommunity
	public let moderator: Person?
}

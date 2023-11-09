//
//  ModTransferCommunityView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModTransferCommunityView: Codable, Hashable {
	public let community: Community
	public let mod_transfer_community: ModTransferCommunity
	public let modded_person: Person
	public let moderator: Person?
}

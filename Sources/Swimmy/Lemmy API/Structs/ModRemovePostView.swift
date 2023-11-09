//
//  ModRemovePostView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModRemovePostView: Codable, Hashable {
	public let community: Community
	public let mod_remove_post: ModRemovePost
	public let moderator: Person?
	public let post: Post
}

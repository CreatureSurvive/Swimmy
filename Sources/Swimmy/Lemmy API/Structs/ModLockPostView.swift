//
//  ModLockPostView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ModLockPostView: Codable, Hashable {
	public let community: Community
	public let mod_lock_post: ModLockPost
	public let moderator: Person?
	public let post: Post
}

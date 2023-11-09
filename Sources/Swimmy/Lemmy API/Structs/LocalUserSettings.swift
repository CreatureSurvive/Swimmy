//
//  LocalUserSettings.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LocalUserSettings: Codable, Identifiable, Hashable {
	public let accepted_application: Bool
	public let default_listing_type: ListingType // changed from int in v0.18
	public let default_sort_type: SortType // changed from int in v0.18
	public let email: String?
	public let email_verified: Bool
	public let id: Int
	public let interface_language: String
	public let person_id: Int
	public let send_notifications_to_email: Bool
	public let show_avatars: Bool
	public let show_bot_accounts: Bool
	public let show_new_post_notifs: Bool
	public let show_nsfw: Bool
	public let show_read_posts: Bool
	public let show_scores: Bool
	public let theme: String
	public let validator_time: String
}

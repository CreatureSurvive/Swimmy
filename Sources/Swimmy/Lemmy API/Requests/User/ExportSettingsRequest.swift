//
//  ExportSettingsRequest.swift
//  
//
//  Created by Dana Buehre on 2/2/24.
//

import Foundation

public struct ExportSettingsRequest: APIRequest {
    public typealias Response = ExportSettingsResponse
    
    public static let httpMethod: HTTPMethod = .get
    public static let path: String = "/user/export_settings"
    public var jwt: String? { return auth }
    
    public let auth: String

    public init(auth: String) {
        self.auth = auth
    }
}

public struct ExportSettingsResponse: APIResponse {
    
    // MARK: - Settings
    public struct Settings: Codable, Identifiable, Hashable, Equatable, Sendable {
        public let show_bot_accounts: Bool
        public let post_listing_mode: String
        public let default_sort_type: String
        public let show_scores: Bool
        public let show_avatars: Bool
        public let blur_nsfw: Bool
        public let person_id: Int
        public let accepted_application: Bool
        public let infinite_scroll_enabled: Bool
        public let admin: Bool
        public let collapse_bot_comments: Bool
        public let email_verified: Bool
        public let id: Int
        public let default_listing_type: String
        public let enable_animated_images: Bool
        public let auto_expand: Bool
        public let show_read_posts: Bool
        public let totp_2fa_enabled: Bool
        public let enable_keyboard_navigation: Bool
        public let send_notifications_to_email: Bool
        public let show_nsfw: Bool
        public let theme: String
        public let open_links_in_new_tab: Bool
        public let interface_language: String
    }
    
    public let saved_posts: [String?]?
    public let blocked_instances: [String?]?
    public let bot_account: Bool?
    public let followed_communities: [String?]?
    public let settings: Settings
    public let bio: String?
    public let avatar: String?
    public let display_name: String?
    public let banner: String?
    public let matrix_id: String?
    public let blocked_communities: [String?]?
    public let saved_comments: [String?]?
    public let blocked_users: [String?]?
}

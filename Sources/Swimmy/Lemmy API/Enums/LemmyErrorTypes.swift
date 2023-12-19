//
//  LemmyErrorTypes.swift
//  
//
//  Created by Dana Buehre on 12/18/23.
//

import Foundation

public enum LemmyError: Error {
    
    case report_reason_required
    case report_too_long
    case not_a_moderator
    case not_an_admin
    case cant_block_yourself
    case cant_block_admin
    case couldnt_update_user
    case passwords_do_not_match
    case email_not_verified
    case email_required
    case couldnt_update_comment
    case couldnt_update_private_message
    case cannot_leave_admin
    case no_lines_in_html
    case site_metadata_page_is_not_doctype_html
    case pictrs_response_error(message: String)
    case pictrs_purge_response_error(message: String)
    case pictrs_caching_disabled
    case image_url_missing_path_segments
    case image_url_missing_last_path_segment
    case pictrs_api_key_not_provided
    case no_content_type_header
    case not_an_image_type
    case not_a_mod_or_admin
    case no_admins
    case not_top_admin
    case not_top_mod
    case not_logged_in
    case site_ban
    case deleted
    case banned_from_community
    case couldnt_find_community
    case couldnt_find_person
    case person_is_blocked
    case community_is_blocked
    case instance_is_blocked
    case downvotes_are_disabled
    case instance_is_private
    case invalid_password
    case site_description_length_overflow
    case honeypot_failed
    case registration_application_is_pending
    case cant_enable_private_instance_and_federation_together
    case locked
    case couldnt_create_comment
    case max_comment_depth_reached
    case no_comment_edit_allowed
    case only_admins_can_create_communities
    case community_already_exists
    case language_not_allowed
    case only_mods_can_post_in_community
    case couldnt_update_post
    case no_post_edit_allowed
    case couldnt_find_post
    case edit_private_message_not_allowed
    case site_already_exists
    case application_question_required
    case invalid_default_post_listing_type
    case registration_closed
    case registration_application_answer_required
    case email_already_exists
    case federation_forbidden_by_strict_allow_list
    case person_is_banned_from_community
    case object_is_not_public
    case invalid_community
    case cannot_create_post_or_comment_in_deleted_or_removed_community
    case cannot_receive_page
    case new_post_cannot_be_locked
    case only_local_admin_can_remove_community
    case only_local_admin_can_restore_community
    case no_id_given
    case incorrect_login
    case invalid_query
    case object_not_local
    case post_is_locked
    case person_is_banned_from_site(message: String)
    case invalid_vote_value
    case page_does_not_specify_creator
    case page_does_not_specify_group
    case no_community_found_in_cc
    case no_email_setup
    case email_smtp_server_needs_a_port
    case missing_an_email
    case rate_limit_error
    case invalid_name
    case invalid_display_name
    case invalid_matrix_id
    case invalid_post_title
    case invalid_body_field
    case bio_length_overflow
    case missing_totp_token
    case missing_totp_secret
    case incorrect_totp_token
    case couldnt_parse_totp_secret
    case couldnt_generate_totp
    case totp_already_enabled
    case couldnt_like_comment
    case couldnt_save_comment
    case couldnt_create_report
    case couldnt_resolve_report
    case community_moderator_already_exists
    case community_user_already_banned
    case community_block_already_exists
    case community_follower_already_exists
    case couldnt_update_community_hidden_status
    case person_block_already_exists
    case user_already_exists
    case token_not_found
    case couldnt_like_post
    case couldnt_save_post
    case couldnt_mark_post_as_read
    case couldnt_update_community
    case couldnt_update_replies
    case couldnt_update_person_mentions
    case post_title_too_long
    case couldnt_create_post
    case couldnt_create_private_message
    case couldnt_update_private
    case system_err_login
    case couldnt_set_all_registrations_accepted
    case couldnt_set_all_email_verified
    case banned
    case couldnt_get_comments
    case couldnt_get_posts
    case invalid_url
    case email_send_failed
    case slurs
    case couldnt_find_object
    case registration_denied(message: String?)
    case federation_disabled
    case domain_blocked(message: String)
    case domain_not_in_allow_list(message: String)
    case federation_disabled_by_strict_allow_list
    case site_name_required
    case site_name_length_overflow
    case permissive_regex
    case invalid_regex
    case captcha_incorrect
    case password_reset_limit_reached
    case couldnt_create_audio_captcha
    case invalid_url_scheme
    case couldnt_send_webmention
    case contradicting_filters
    case instance_block_already_exists
    case too_many_items
    case community_has_no_followers
    case ban_expiration_in_past
    case invalid_unix_time
    case invalid_bot_action
    case cant_block_local_instance
    case unknown(message: String)
    
    public static func error(rawValue: String, message: String?) -> LemmyError {
        let message = message ?? "swimmy_unknown_error"
        
        switch rawValue {
        case "report_reason_required": return .report_reason_required
        case "report_too_long": return .report_too_long
        case "not_a_moderator": return .not_a_moderator
        case "not_an_admin": return .not_an_admin
        case "cant_block_yourself": return .cant_block_yourself
        case "cant_block_admin": return .cant_block_admin
        case "couldnt_update_user": return .couldnt_update_user
        case "passwords_do_not_match": return .passwords_do_not_match
        case "email_not_verified": return .email_not_verified
        case "email_required": return .email_required
        case "couldnt_update_comment": return .couldnt_update_comment
        case "couldnt_update_private_message": return .couldnt_update_private_message
        case "cannot_leave_admin": return .cannot_leave_admin
        case "no_lines_in_html": return .no_lines_in_html
        case "site_metadata_page_is_not_doctype_html": return .site_metadata_page_is_not_doctype_html
        case "pictrs_response_error": return .pictrs_response_error(message: message)
        case "pictrs_purge_response_error": return .pictrs_purge_response_error(message: message)
        case "pictrs_caching_disabled": return .pictrs_caching_disabled
        case "image_url_missing_path_segments": return .image_url_missing_path_segments
        case "image_url_missing_last_path_segment": return .image_url_missing_last_path_segment
        case "pictrs_api_key_not_provided": return .pictrs_api_key_not_provided
        case "no_content_type_header": return .no_content_type_header
        case "not_an_image_type": return .not_an_image_type
        case "not_a_mod_or_admin": return .not_a_mod_or_admin
        case "no_admins": return .no_admins
        case "not_top_admin": return .not_top_admin
        case "not_top_mod": return .not_top_mod
        case "not_logged_in": return .not_logged_in
        case "site_ban": return .site_ban
        case "deleted": return .deleted
        case "banned_from_community": return .banned_from_community
        case "couldnt_find_community": return .couldnt_find_community
        case "couldnt_find_person": return .couldnt_find_person
        case "person_is_blocked": return .person_is_blocked
        case "community_is_blocked": return .community_is_blocked
        case "instance_is_blocked": return .instance_is_blocked
        case "downvotes_are_disabled": return .downvotes_are_disabled
        case "instance_is_private": return .instance_is_private
        case "invalid_password": return .invalid_password
        case "site_description_length_overflow": return .site_description_length_overflow
        case "honeypot_failed": return .honeypot_failed
        case "registration_application_is_pending": return .registration_application_is_pending
        case "cant_enable_private_instance_and_federation_together": return .cant_enable_private_instance_and_federation_together
        case "locked": return .locked
        case "couldnt_create_comment": return .couldnt_create_comment
        case "max_comment_depth_reached": return .max_comment_depth_reached
        case "no_comment_edit_allowed": return .no_comment_edit_allowed
        case "only_admins_can_create_communities": return .only_admins_can_create_communities
        case "community_already_exists": return .community_already_exists
        case "language_not_allowed": return .language_not_allowed
        case "only_mods_can_post_in_community": return .only_mods_can_post_in_community
        case "couldnt_update_post": return .couldnt_update_post
        case "no_post_edit_allowed": return .no_post_edit_allowed
        case "couldnt_find_post": return .couldnt_find_post
        case "edit_private_message_not_allowed": return .edit_private_message_not_allowed
        case "site_already_exists": return .site_already_exists
        case "application_question_required": return .application_question_required
        case "invalid_default_post_listing_type": return .invalid_default_post_listing_type
        case "registration_closed": return .registration_closed
        case "registration_application_answer_required": return .registration_application_answer_required
        case "email_already_exists": return .email_already_exists
        case "federation_forbidden_by_strict_allow_list": return .federation_forbidden_by_strict_allow_list
        case "person_is_banned_from_community": return .person_is_banned_from_community
        case "object_is_not_public": return .object_is_not_public
        case "invalid_community": return .invalid_community
        case "cannot_create_post_or_comment_in_deleted_or_removed_community": return .cannot_create_post_or_comment_in_deleted_or_removed_community
        case "cannot_receive_page": return .cannot_receive_page
        case "new_post_cannot_be_locked": return .new_post_cannot_be_locked
        case "only_local_admin_can_remove_community": return .only_local_admin_can_remove_community
        case "only_local_admin_can_restore_community": return .only_local_admin_can_restore_community
        case "no_id_given": return .no_id_given
        case "incorrect_login": return .incorrect_login
        case "invalid_query": return .invalid_query
        case "object_not_local": return .object_not_local
        case "post_is_locked": return .post_is_locked
        case "person_is_banned_from_site": return .person_is_banned_from_site(message: message)
        case "invalid_vote_value": return .invalid_vote_value
        case "page_does_not_specify_creator": return .page_does_not_specify_creator
        case "page_does_not_specify_group": return .page_does_not_specify_group
        case "no_community_found_in_cc": return .no_community_found_in_cc
        case "no_email_setup": return .no_email_setup
        case "email_smtp_server_needs_a_port": return .email_smtp_server_needs_a_port
        case "missing_an_email": return .missing_an_email
        case "rate_limit_error": return .rate_limit_error
        case "invalid_name": return .invalid_name
        case "invalid_display_name": return .invalid_display_name
        case "invalid_matrix_id": return .invalid_matrix_id
        case "invalid_post_title": return .invalid_post_title
        case "invalid_body_field": return .invalid_body_field
        case "bio_length_overflow": return .bio_length_overflow
        case "missing_totp_token": return .missing_totp_token
        case "missing_totp_secret": return .missing_totp_secret
        case "incorrect_totp_token": return .incorrect_totp_token
        case "couldnt_parse_totp_secret": return .couldnt_parse_totp_secret
        case "couldnt_generate_totp": return .couldnt_generate_totp
        case "totp_already_enabled": return .totp_already_enabled
        case "couldnt_like_comment": return .couldnt_like_comment
        case "couldnt_save_comment": return .couldnt_save_comment
        case "couldnt_create_report": return .couldnt_create_report
        case "couldnt_resolve_report": return .couldnt_resolve_report
        case "community_moderator_already_exists": return .community_moderator_already_exists
        case "community_user_already_banned": return .community_user_already_banned
        case "community_block_already_exists": return .community_block_already_exists
        case "community_follower_already_exists": return .community_follower_already_exists
        case "couldnt_update_community_hidden_status": return .couldnt_update_community_hidden_status
        case "person_block_already_exists": return .person_block_already_exists
        case "user_already_exists": return .user_already_exists
        case "token_not_found": return .token_not_found
        case "couldnt_like_post": return .couldnt_like_post
        case "couldnt_save_post": return .couldnt_save_post
        case "couldnt_mark_post_as_read": return .couldnt_mark_post_as_read
        case "couldnt_update_community": return .couldnt_update_community
        case "couldnt_update_replies": return .couldnt_update_replies
        case "couldnt_update_person_mentions": return .couldnt_update_person_mentions
        case "post_title_too_long": return .post_title_too_long
        case "couldnt_create_post": return .couldnt_create_post
        case "couldnt_create_private_message": return .couldnt_create_private_message
        case "couldnt_update_private": return .couldnt_update_private
        case "system_err_login": return .system_err_login
        case "couldnt_set_all_registrations_accepted": return .couldnt_set_all_registrations_accepted
        case "couldnt_set_all_email_verified": return .couldnt_set_all_email_verified
        case "banned": return .banned
        case "couldnt_get_comments": return .couldnt_get_comments
        case "couldnt_get_posts": return .couldnt_get_posts
        case "invalid_url": return .invalid_url
        case "email_send_failed": return .email_send_failed
        case "slurs": return .slurs
        case "couldnt_find_object": return .couldnt_find_object
        case "registration_denied": return .registration_denied(message: message)
        case "federation_disabled": return .federation_disabled
        case "domain_blocked": return .domain_blocked(message: message)
        case "domain_not_in_allow_list": return .domain_not_in_allow_list(message: message)
        case "federation_disabled_by_strict_allow_list": return .federation_disabled_by_strict_allow_list
        case "site_name_required": return .site_name_required
        case "site_name_length_overflow": return .site_name_length_overflow
        case "permissive_regex": return .permissive_regex
        case "invalid_regex": return .invalid_regex
        case "captcha_incorrect": return .captcha_incorrect
        case "password_reset_limit_reached": return .password_reset_limit_reached
        case "couldnt_create_audio_captcha": return .couldnt_create_audio_captcha
        case "invalid_url_scheme": return .invalid_url_scheme
        case "couldnt_send_webmention": return .couldnt_send_webmention
        case "contradicting_filters": return .contradicting_filters
        case "instance_block_already_exists": return .instance_block_already_exists
        case "too_many_items": return .too_many_items
        case "community_has_no_followers": return .community_has_no_followers
        case "ban_expiration_in_past": return .ban_expiration_in_past
        case "invalid_unix_time": return .invalid_unix_time
        case "invalid_bot_action": return .invalid_bot_action
        case "cant_block_local_instance": return .cant_block_local_instance
        case "unknown": return .unknown(message: message)
        default: return .unknown(message: message)
        }
    }
}

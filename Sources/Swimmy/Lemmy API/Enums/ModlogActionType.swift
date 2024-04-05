//
//  ModlogActionType.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public enum ModlogActionType: String, Codable, CustomStringConvertible, CaseIterable, Sendable {
	case adminPurgeComment = "AdminPurgeComment"
	case adminPurgeCommunity = "AdminPurgeCommunity"
	case adminPurgePerson = "AdminPurgePerson"
	case adminPurgePost = "AdminPurgePost"
	case all = "All"
	case modAdd = "ModAdd"
	case modAddCommunity = "ModAddCommunity"
	case modBan = "ModBan"
	case modBanFromCommunity = "ModBanFromCommunity"
	case modFeaturePost = "ModFeaturePost"
	case modHideCommunity = "ModHideCommunity"
	case modLockPost = "ModLockPost"
	case modRemoveComment = "ModRemoveComment"
	case modRemoveCommunity = "ModRemoveCommunity"
	case modRemovePost = "ModRemovePost"
	case modTransferCommunity = "ModTransferCommunity"

	public var description: String {
		return self.rawValue
	}
    
    public var displayName: String {
        switch self {
        case .adminPurgeComment: return "Purge Comment"
        case .adminPurgeCommunity: return "Purge Community"
        case .adminPurgePerson: return "Purge Person"
        case .adminPurgePost: return "Purge Post"
        case .all: return "All"
        case .modAdd: return "Add Mod"
        case .modAddCommunity: return "Add Community"
        case .modBan: return "Ban From Instance"
        case .modBanFromCommunity: return "Ban From Community"
        case .modFeaturePost: return "Feature Post"
        case .modHideCommunity: return "Hide Community"
        case .modLockPost: return "Lock Post"
        case .modRemoveComment: return "Remove Comment"
        case .modRemoveCommunity: return "Remove Community"
        case .modRemovePost: return "Remove Post"
        case .modTransferCommunity: return "Transfer Community"
        }
    }
    
    public static let listableTypes: [ModlogActionType] = [
        .all,
        .modAdd,
        .modAddCommunity,
        .modBan,
        .modBanFromCommunity,
        .modFeaturePost,
        .modHideCommunity,
        .modLockPost,
        .modRemoveComment,
        .modRemoveCommunity,
        .modRemovePost,
        .modTransferCommunity,
    ]
}

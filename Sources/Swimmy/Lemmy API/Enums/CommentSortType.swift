//
//  CommentSortType.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public enum CommentSortType: String, Codable, CustomStringConvertible, CaseIterable {
	case hot = "Hot"
	case new = "New"
	case old = "Old"
	case top = "Top"

	public var description: String {
		return self.rawValue
	}
    
    public var imageName: String {
        return CommentSortType.imageName(type: self)
    }
    
    public static func imageName(type: CommentSortType) -> String {
        switch type {
        case .hot: return "flame"
        case .new: return "clock"
        case .old: return "arrow.down"
        case .top: return "arrow.up"
        }
    }
}

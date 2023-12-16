//
//  SortType.swift
//
//
//  Created by Dana Buehre on 6/10/23.
//

import Foundation

/// Different post sort types used in lemmy.
public enum SortType: String, Codable, CustomStringConvertible, CaseIterable {
	case active = "Active"
	case hot = "Hot"
	case mostComments = "MostComments"
	case new = "New"
	case newComments = "NewComments"
	case old = "Old"
    case controversial = "Controversial"
    case scaled =  "Scaled"
	case topAll = "TopAll"
	case topDay = "TopDay"
	case topMonth = "TopMonth"
	case topWeek = "TopWeek"
	case topYear = "TopYear"
    case topHour = "TopHour"
    case topSixHour = "TopSixHour"
    case topTwelveHour = "TopTwelveHour"
    case topThreeMonths = "TopThreeMonths"
    case topSixMonths = "TopSixMonths"
    case topNineMonths = "TopNineMonths"

	public var description: String {
		return self.rawValue
	}
    
    public var label: String {
        switch self {
        case .active: return "Active"
        case .hot: return "Hot"
        case .mostComments: return "Most Comments"
        case .new: return "New"
        case .newComments: return "New Comments"
        case .old: return "Old"
        case .controversial: return "Controversial"
        case .scaled: return "Scaled"
        case .topAll: return "Top All"
        case .topDay: return "Top Day"
        case .topMonth: return "Top Month"
        case .topWeek: return "Top Week"
        case .topYear: return "Top Year"
        case .topHour: return "Top Hour"
        case .topSixHour: return "Top 6 Hour"
        case .topTwelveHour: return "Top 12 Hour"
        case .topThreeMonths: return "Top 3 Month"
        case .topSixMonths: return "Top 6 Month"
        case .topNineMonths: return "Top 9 Month"
        }
    }
    
    public var imageName: String {
        return SortType.imageName(type: self)
    }
    
    public static var allTypes: [SortType] {
        return [.hot, .new, .active, .newComments, .mostComments, .old, .topAll, .topHour, .topSixHour, .topTwelveHour, .topDay, .topWeek, .topMonth, .topThreeMonths, .topNineMonths, .topYear]
    }
    
    public static var allNonTopTypes: [SortType] {
        return [.hot, .new, .active, .newComments, .mostComments, .old]
    }
    
    public static var allTypesV19: [SortType] {
        return [.hot, .new, .active, .newComments, .mostComments, .old, .controversial, .scaled, .topAll, .topHour, .topSixHour, .topTwelveHour, .topDay, .topWeek, .topMonth, .topThreeMonths, .topNineMonths, .topYear]
    }
    
    public static var allNonTopTypesV19: [SortType] {
        return [.hot, .new, .active, .newComments, .mostComments, .old, .controversial, .scaled]
    }
    
    public static var allTopTypes: [SortType] {
        return [.topAll, .topHour, .topSixHour, .topTwelveHour, .topDay, .topWeek, .topMonth, .topThreeMonths, .topNineMonths, .topYear]
    }
    
    public static func imageName(type: SortType) -> String {
        switch type {
        case .active: return "hare"
        case .hot: return "flame"
        case .mostComments: return "list.bullet.indent"
        case .new: return "clock"
        case .newComments: return "text.badge.plus"
        case .old: return "arrow.down"
        case .controversial: return "arrow.up.arrow.down"
        case .scaled: return "scale.3d"
        case .topAll: return "arrow.up"
        case .topDay: return "calendar"
        case .topMonth: return "calendar"
        case .topWeek: return "calendar"
        case .topYear: return "calendar"
        case .topHour: return "calendar"
        case .topSixHour: return "calendar"
        case .topTwelveHour: return "calendar"
        case .topThreeMonths: return "calendar"
        case .topSixMonths: return "calendar"
        case .topNineMonths: return "calendar"
        }
    }
}

//
//  Date.swift
//  
//
//  Created by Dana Buehre on 11/9/23.
//

import Foundation

extension Date {
    
    /// returns a string in the format `5(s,m,h,d,w,mo,y)` eg: `5m`
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current

        if calendar.date(byAdding: .minute, value: -1, to: .now)! < self { // less than minute ago
            let diff = calendar.dateComponents([.second], from: self, to: .now).second ?? 0
            return "\(diff)s"
        } else if calendar.date(byAdding: .hour, value: -1, to: .now)! < self { // less than hour ago
            let diff = calendar.dateComponents([.minute], from: self, to: .now).minute ?? 0
            return "\(diff)m"
        } else if calendar.date(byAdding: .day, value: -1, to: .now)! < self { // less than day ago
            let diff = calendar.dateComponents([.hour], from: self, to: .now).hour ?? 0
            return "\(diff)h"
        } else if calendar.date(byAdding: .day, value: -7, to: .now)! < self { // less than week ago
            let diff = calendar.dateComponents([.day], from: self, to: .now).day ?? 0
            return "\(diff)d"
        } else if calendar.date(byAdding: .month, value: -1, to: .now)! < self { // less than month ago
            let diff = calendar.dateComponents([.weekOfYear], from: self, to: .now).weekOfYear ?? 0
            return "\(diff)w"
        } else if calendar.date(byAdding: .year, value: -1, to: .now)! < self { // less than year ago
            let diff = calendar.dateComponents([.month], from: self, to: .now).month ?? 0
            return "\(diff)mo"
        }
        let diff = calendar.dateComponents([.year], from: self, to: .now).year ?? 0
        return "\(diff)y"
    }

    /// converts the date from one timezone to another
    func convert(from timeZone: TimeZone, to destinationTimeZone: TimeZone) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(in: timeZone, from: self)
        components.timeZone = destinationTimeZone
        return calendar.date(from: components)!
    }
    
    static func date(string: String) -> Date? {
        DateHelpers.dateForString(string)
    }
}

struct DateHelpers {
    
    /// possible formats used by Lemmy
    static let dateFormats: [String] = [
        "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSSSSS",
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss",
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
        "yyyy-MM-dd HH:mm:ss.SSSSSS",
        "yyyy-MM-dd HH:mm:ssZ",
        "yyyy-MM-dd HH:mm:ss",
        "yyyy-MM-dd HH:mm"
    ]
    
    /// the GMT timezone
    static let GMT: TimeZone = TimeZone(identifier: "GMT")!
    
    /// the current time in the GMT timezone
    static var nowGMT: Date {
        return .now.convert(from: Calendar.current.timeZone, to: GMT)
    }
    
    /// formatters for each format used by Lemmy
    static let formatters: [DateFormatter] = dateFormats.map { format in
        let formatter = DateFormatter()
        formatter.timeZone = GMT
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
    
    static let ISO8061Formatter: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()
    
    static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = GMT
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    /// formatter used to produce a time since string
    static var timeSinceFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .numeric
        formatter.unitsStyle = .full
        formatter.formattingContext = .standalone
        formatter.calendar = .autoupdatingCurrent
        return formatter
    }()
    
    static func timeSinceLong(timestamp: String) -> String? {
        guard let date = dateForString(timestamp) else { return nil }
        return timeSinceFormatter.localizedString(for: date, relativeTo: nowGMT)
    }
    
    static func timeSinceLong(timestamp: Date) -> String? {
        return timeSinceFormatter.localizedString(for: timestamp, relativeTo: nowGMT)
    }
    
    static func dateForString(_ string: String) -> Date? {
        
        if let date = ISO8061Formatter.date(from: string) {
            return date
        }
        
        for formatter in formatters {
            guard let date = formatter.date(from: string) else { continue }
            return date
        }
        
        return nil
    }
}

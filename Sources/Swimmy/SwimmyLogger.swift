//
//  SwimmyLogger.swift
//  
//
//  Created by Dana Buehre on 12/10/23.
//

import Foundation
#if canImport(Logging)
import Logging
#endif

public struct SwimmyLogger {
    internal enum LogType: String {
        case trace, debug, info, notice, warning, error, critical
#if canImport(Logging)
        var level: Logger.Level {
            return Logger.Level(rawValue: self.rawValue) ?? .info
        }
#endif
    }

#if canImport(Logging)
    public static var logger: Logger? = Logger(label: "swimmy") { label, provider in
        StreamLogHandler.standardOutput(label: label)
    }
#endif
    
    internal static func log(_ message: String, logType: LogType = .info, function: StaticString = #function) {
#if canImport(Logging)
        if let logger = logger {
            logger.log(level: logType.level, "[\(function)] \(message)")
        } else {
            print("[\(Date())] [\(logType.rawValue)] [\(function)] \(message)")
        }
#else
        print("[\(Date())] [\(logType.rawValue)] [\(function)] \(message)")
#endif
    }
}

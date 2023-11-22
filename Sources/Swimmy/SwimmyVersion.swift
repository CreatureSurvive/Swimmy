//
//  SwimmyVersion.swift
//  
//
//  Created by Dana Buehre on 11/12/23.
//

import Foundation

public struct SwimmyVersion {
    public static let version: String = "1.0"
    public static let build: String = "0"
    
    public static var fullVersion: String {
        "\(version).\(build)"
    }
    
    public static var userAgent: String {
        "Swimmy/\(fullVersion); (Lemmy Swift API)"
    }
}

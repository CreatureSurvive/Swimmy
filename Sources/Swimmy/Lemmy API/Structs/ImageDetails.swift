//
//  ImageDetails.swift
//  Swimmy
//
//  Created by Dana Buehre on 11/16/24.
//

import Foundation

public struct ImageDetails: Codable, Hashable, Sendable {
    let link: String
    let width: Float
    let height: Float
    let content_type: String
    
    public init(link: String, width: Float, height: Float, content_type: String) {
        self.link = link
        self.width = width
        self.height = height
        self.content_type = content_type
    }
}

//
//  Language.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct Language: Codable, Identifiable, Hashable, Sendable {
    public let code: String
    public let id: Int
    public let name: String

    public init(code: String, id: Int, name: String) {
        self.code = code
        self.id = id
        self.name = name
    }    
}

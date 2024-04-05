//
//  ImageFile.swift
//  lemming
//
//  Created by Dana Buehre on 7/3/23.
//

import Foundation

public struct ImageFile: Codable, Hashable, Sendable {
    public let delete_token: String
    public let file: String

    public init(delete_token: String, file: String) {
        self.delete_token = delete_token
        self.file = file
    }
}

//
//  ImageFile.swift
//  lemming
//
//  Created by Dana Buehre on 7/3/23.
//

import Foundation

public struct ImageFile: Codable, Hashable {
    public let delete_token: String
    public let file: String
}

//
//  LocalImage.swift
//  Swimmy
//
//  Created by Dana Buehre on 2/3/25.
//

import Foundation

public struct LocalImage: Codable, Hashable, Sendable {
    public let local_user_id: Int?
    public let pictrs_alias: String
    public let published: String

    public  init(local_user_id: Int? = nil, pictrs_alias: String, published: String) {
        self.local_user_id = local_user_id
        self.pictrs_alias = pictrs_alias
        self.published = published
    }
}

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
    /// removed in v0.20
    /// - Note: see https://github.com/LemmyNet/lemmy-js-client/commit/9972e1badf3e40e844d2200d2591b2a8ea9cc2db
    public let pictrs_delete_token: String?
    public let published: String

    public  init(local_user_id: Int? = nil, pictrs_alias: String, pictrs_delete_token: String?, published: String) {
        self.local_user_id = local_user_id
        self.pictrs_alias = pictrs_alias
        self.pictrs_delete_token = pictrs_delete_token
        self.published = published
    }
}

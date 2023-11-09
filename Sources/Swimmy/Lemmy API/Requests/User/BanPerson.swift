//
//  BanPerson.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct BanPersonRequest: APIRequest {
    public typealias Response = BanPersonResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/user/ban"
    public var jwt: String? { return auth }

    public let auth: String
    public let ban: Bool
    /// The expire time in Unix seconds.
    public let expires: Int?
    public let person_id: Int
    public let reason: String?
    /// Removes/Restores their comments, posts, and communities.
    public let remove_data: Bool?
    
    public init(auth: String, ban: Bool, expires: Int? = nil, person_id: Int, reason: String? = nil, remove_data: Bool? = nil) {
        self.auth = auth
        self.ban = ban
        self.expires = expires
        self.person_id = person_id
        self.reason = reason
        self.remove_data = remove_data
    }
}
public struct BanPersonResponse: APIResponse {
    public let banned: Bool
    public let person_view: PersonView
}

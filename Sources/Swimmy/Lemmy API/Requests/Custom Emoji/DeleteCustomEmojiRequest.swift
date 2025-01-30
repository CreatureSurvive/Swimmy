//
//  DeleteCustomEmojiRequest.swift
//  Swimmy
//
//  Created by Dana Buehre on 1/29/25.
//

import Foundation

public struct DeleteCustomEmojiRequest: APIRequest {
    public typealias Response = SuccessResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/custom_emoji/delete"
    public var jwt: String? { return auth }

    public let auth: String
    public let id: Int

    public init(auth: String, id: Int) {
        self.auth = auth
        self.id = id
    }
}

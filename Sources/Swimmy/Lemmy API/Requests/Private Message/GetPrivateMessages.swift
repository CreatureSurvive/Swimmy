//
//  GetPrivateMessages.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetPrivateMessagesRequest: APIRequest {
	public typealias Response = PrivateMessagesResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/private_message/list"
    public var jwt: String? { return auth }

	public let auth: String
	public let limit: Int?
	public let page: Int?
	public let unread_only: Bool?
    public let creator_id: Bool? // v0.19 added

    public init(auth: String, limit: Int? = nil, page: Int? = nil, unread_only: Bool? = nil, creator_id: Bool? = nil) {
		self.auth = auth
		self.limit = limit
		self.page = page
		self.unread_only = unread_only
        self.creator_id = creator_id
	}
}
public struct PrivateMessagesResponse: APIResponse {
	public let private_messages: [PrivateMessageView]
}

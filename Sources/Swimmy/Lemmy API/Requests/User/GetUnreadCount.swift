//
//  GetUnreadCount.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetUnreadCountRequest: APIRequest {
	public typealias Response = GetUnreadCountResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/user/unread_count"
    public var jwt: String? { return auth }

	public let auth: String

	public init(auth: String) {
		self.auth = auth
	}
}
public struct GetUnreadCountResponse: APIResponse, Equatable {
	public let mentions: Int
	public let private_messages: Int
	public let replies: Int
}

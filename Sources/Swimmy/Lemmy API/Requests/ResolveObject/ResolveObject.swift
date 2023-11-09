//
//  ResolveObject.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ResolveObjectRequest: APIRequest {
	public typealias Response = ResolveObjectResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/resolve_object"
    public var jwt: String? { return auth }

	public let auth: String?
	public let q: String

	public init(auth: String? = nil, q: String) {
		self.auth = auth
		self.q = q
	}
}
public struct ResolveObjectResponse: APIResponse {
	public let comment: CommentView?
	public let community: CommunityView?
	public let person: PersonView?
	public let post: PostView?
}

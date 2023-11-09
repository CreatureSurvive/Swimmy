//
//  GetSite.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetSiteRequest: APIRequest {
	public typealias Response = GetSiteResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/site"
    public var jwt: String? { return auth }

	public let auth: String?

	public init(auth: String? = nil) {
		self.auth = auth
	}
}
public struct GetSiteResponse: APIResponse {
	public let admins: [PersonView]
	public let all_languages: [Language]
	public let discussion_languages: [Int]
	public let federated_instances: FederatedInstances?
	public let my_user: MyUserInfo?
	public let online: Int? // removed v0.18
	public let site_view: SiteView
	public let taglines: [Tagline]?
	public let version: String
}

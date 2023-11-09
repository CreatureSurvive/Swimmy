//
//  LeaveAdmin.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct LeaveAdminRequest: APIRequest {
	public typealias Response = GetSiteResponse
	
	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/user/leave_admin"
    public var jwt: String? { return auth }
	
	public let auth: String
	
	public init(auth: String) {
		self.auth = auth
	}
}

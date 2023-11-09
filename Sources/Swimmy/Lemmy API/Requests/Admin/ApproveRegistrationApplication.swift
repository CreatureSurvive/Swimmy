//
//  ApproveRegistrationApplication.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct ApproveRegistrationApplicationRequest: APIRequest {
    public typealias Response = RegistrationApplicationResponse

    public static let httpMethod: HTTPMethod = .put
    public static let path: String = "/admin/registration_application/approve"
    public var jwt: String? { return auth }

    public let auth: String
    public let approve: Bool
    public let deny_reason: String?
    public let id: Int

    public init(auth: String, approve: Bool, deny_reason: String? = nil, id: Int) {
        self.auth = auth
        self.approve = approve
        self.deny_reason = deny_reason
        self.id = id
    }
}
public struct RegistrationApplicationResponse: APIResponse {
	public let registration_application: RegistrationApplicationView
}

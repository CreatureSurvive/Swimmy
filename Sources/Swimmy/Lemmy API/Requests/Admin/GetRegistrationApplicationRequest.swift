//
//  GetRegistrationApplicationRequest.swift
//  Swimmy
//
//  Created by Dana Buehre on 11/16/24.
//

// v0.19.6 added
public struct GetRegistrationApplicationRequest: APIRequest {
    public typealias Response = GetRegistrationApplicationResponse
    
    public static let httpMethod: HTTPMethod = .get
    public static let path: String = "/admin/registration_application"
    public var jwt: String? { return auth }
    
    public let auth: String
    public let person_id: Int
    
    public init(auth: String, person_id: Int) {
        self.auth = auth
        self.person_id = person_id
    }
}
public struct GetRegistrationApplicationResponse: APIResponse {
    public let registration_application: RegistrationApplicationView
}

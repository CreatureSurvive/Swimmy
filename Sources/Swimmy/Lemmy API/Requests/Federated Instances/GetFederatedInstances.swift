//
//  GetFederatedInstances.swift
//  Arctic
//
//  Created by Dana Buehre on 8/31/23.
//

import Foundation

public struct GetFederatedInstances: APIRequest {
    public typealias Response = GetFederatedInstancesResponse

    public static let httpMethod: HTTPMethod = .get
    public static let path: String = "/federated_instances"
    public var jwt: String? { return auth }

    public let auth: String?

    public init(auth: String? = nil) {
        self.auth = auth
    }
}
public struct GetFederatedInstancesResponse: APIResponse {
    public let federated_instances: FederatedInstances?
}

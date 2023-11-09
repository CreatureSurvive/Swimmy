//
//  BlockInstanceRequest.swift
//  Arctic
//
//  Created by Dana Buehre on 10/3/23.
//

import Foundation

public struct BlockInstance: APIRequest {
    public typealias Response = BlockInstanceResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/site/block"
    public var jwt: String? { return auth }
    
    public let auth: String
    public let instance_id: Int
    public let block: Bool
    
    init(auth: String, instance_id: Int, block: Bool) {
        self.auth = auth
        self.instance_id = instance_id
        self.block = block
    }
}

public struct BlockInstanceResponse: APIResponse {
    let blocked: Bool
}

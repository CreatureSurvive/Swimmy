//
//  LoginToken.swift
//  
//
//  Created by Dana Buehre on 11/30/23.
//

import Foundation

public struct LoginToken: Codable, Hashable {
    public let user_id: Int
    public let published: String
    public let ip: String?
    public let user_agent: String?
}

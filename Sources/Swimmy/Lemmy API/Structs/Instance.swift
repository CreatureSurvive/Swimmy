//
//  Instance.swift
//  Arctic
//
//  Created by Dana Buehre on 9/4/23.
//

import Foundation

public struct Instance: Codable, Identifiable, Hashable, Sendable {
    public let id: Int
    public let domain: String
    public let published: String
    public let updated: String?
    public let software: String?
    public let version: String?
    public let federation_state: ReadableFederationState?
    
    public init(id: Int, domain: String, published: String, updated: String? = nil, software: String? = nil, version: String? = nil, federation_state: ReadableFederationState?) {
        self.id = id
        self.domain = domain
        self.published = published
        self.updated = updated
        self.software = software
        self.version = version
        self.federation_state = federation_state
    }
}

public struct ReadableFederationState: Codable, Hashable, Sendable {
   public let instance_id: Int
   public let last_successful_id: Int?
   public let last_successful_published_time: String?
   public let fail_count: Int
   public let last_retry: String?
   public let next_retry: String?
 }

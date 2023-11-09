//
//  CommunityBlockView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommunityBlockView: Codable, Hashable {
    public let community: Community
    public let person: Person
    
    public init(community: Community, person: Person) {
        self.community = community
        self.person = person
    }
}

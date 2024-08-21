//
//  HidePost.swift
//
//
//  Created by Dana Buehre on 8/16/24.
//

import Foundation

/// Hide a post from list views, available in v0.19.4
public struct HidePost: APIRequest {
    public typealias Response = PostResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/post/hide"
    public var jwt: String? { return auth }

    public let auth: String
    public let post_ids: [Int]
    public let hide: Bool

    public init(auth: String, post_ids: [Int], hide: Bool) {
        self.auth = auth
        self.post_ids = post_ids
        self.hide = hide
    }
    
    public init(auth: String, post_id: Int, hide: Bool) {
        self.auth = auth
        self.post_ids = [post_id]
        self.hide = hide
    }
}

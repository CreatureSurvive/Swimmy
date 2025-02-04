//
//  ListImagesRequest.swift
//  Swimmy
//
//  Created by Dana Buehre on 2/3/25.
//


import Foundation

public struct ListMediaRequest: APIRequest {
    public typealias Response = ListMediaResponse

    public static let httpMethod: HTTPMethod = .put
    public static let path: String = "/account/list_media"
    public var jwt: String? { return auth }

    public let auth: String
    public let page: Int?
    public let limit: Int?

    public init(auth: String, page: Int? = nil, limit: Int? = nil) {
        self.auth = auth
        self.page = page
        self.limit = limit
    }
}

public struct ListMediaResponse: APIResponse {
    let images: [LocalImageView]
}

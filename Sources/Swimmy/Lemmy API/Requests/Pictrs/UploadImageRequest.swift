//
//  UploadImageRequest.swift
//  lemming
//
//  Created by Dana Buehre on 7/3/23.
//

import Foundation

public struct UploadImageRequest: APIRequest {
    public typealias Response = UploadImageResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/pictrs/image"
    public var jwt: String? { return auth }

    public let auth: String?
    public let image: Data

    public init(auth: String?, image: Data) {
        self.auth = auth
        self.image = image
    }
}

public struct UploadImageResponse: APIResponse {
    public let delete_url: String?
    public let files: [ImageFile]?
    /// Is "ok" if the upload was successful; is something else otherwise.
    public let msg: String
    public let url: String?

}

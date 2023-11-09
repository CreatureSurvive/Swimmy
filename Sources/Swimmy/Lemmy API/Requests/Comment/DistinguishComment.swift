import Foundation

public struct DistinguishCommentRequest: APIRequest {
    public typealias Response = CommentResponse

    public static let httpMethod: HTTPMethod = .post
    public static let path: String = "/comment/distinguish"
    public var jwt: String? { return auth }

    public let comment_id: Int
    public let distinguished: Bool
    public let auth: String

    public init(
        comment_id: Int,
        distinguished: Bool,
        auth: String
    ) {
        self.comment_id = comment_id
        self.distinguished = distinguished
        self.auth = auth
    }
}

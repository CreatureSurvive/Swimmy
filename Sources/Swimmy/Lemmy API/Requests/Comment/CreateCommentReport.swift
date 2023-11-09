//
//  CreateCommentReport.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CreateCommentReportRequest: APIRequest {
	public typealias Response = CommentReportResponse

	public static let httpMethod: HTTPMethod = .post
	public static let path: String = "/comment/report"
    public var jwt: String? { return auth }

	public let auth: String
	public let comment_id: Int
	public let reason: String

	public init(auth: String, comment_id: Int, reason: String) {
		self.auth = auth
		self.comment_id = comment_id
		self.reason = reason
	}
}
public struct CommentReportResponse: APIResponse {
	public let comment_report_view: CommentReportView
}

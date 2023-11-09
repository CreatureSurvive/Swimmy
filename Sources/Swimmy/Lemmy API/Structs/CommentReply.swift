//
//  CommentReply.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct CommentReply: Codable, Identifiable, Hashable {
	public let comment_id: Int
	public let id: Int
	public let published: String
	public var read: Bool
	public let recipient_id: Int
}

//
//  GetComment.swift
//  Arctic
//
//  Created by Dana Buehre on 7/9/23.
//

import Foundation

 public struct GetCommentRequest: APIRequest {
     public typealias Response = CommentResponse

     public static let httpMethod: HTTPMethod = .get
     public static let path: String = "/comment"
     public var jwt: String? { return auth }

     public let auth: String?
     public let id: Int

     public init(
         auth: String? = nil,
         id: Int
     ) {
         self.auth = auth
         self.id = id
     }
 }

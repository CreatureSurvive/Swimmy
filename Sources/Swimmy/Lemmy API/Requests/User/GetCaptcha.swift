//
//  GetCaptcha.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct GetCaptchaRequest: APIRequest {
	public typealias Response = GetCaptchaResponse

	public static let httpMethod: HTTPMethod = .get
	public static let path: String = "/user/get_captcha"
    public var jwt: String? { return nil }

	public init() {}
}
public struct GetCaptchaResponse: APIResponse {
	/// Will be nil if captchas are disabled.
	public let ok: CaptchaResponse?
}

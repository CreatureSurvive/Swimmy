//
//  PrivateMessageReportView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct PrivateMessageReportView: Codable, Hashable {
	public let creator: Person
	public let private_message: PrivateMessage
	public let private_message_creator: Person
	public let private_message_report: PrivateMessageReport
	public let resolver: Person?
}

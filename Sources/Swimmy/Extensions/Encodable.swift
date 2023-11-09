//
//  Encodable.swift
//  
//
//  Created by Dana Buehre on 11/7/23.
//

import Foundation

extension Encodable {
    var prettyPrintedJSONString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8) ?? nil
    }
}

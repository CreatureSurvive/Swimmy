//
//  String.swift
//  
//
//  Created by Dana Buehre on 11/7/23.
//

import Foundation

extension String {
    init?(data: Data, textEncodingName: String? = nil, `default`: String.Encoding = .utf8) {
        let encoding: String.Encoding = {
            if let textEncodingName = textEncodingName {
                let cfEncoding = CFStringConvertIANACharSetNameToEncoding(textEncodingName as CFString)
                if cfEncoding != kCFStringEncodingInvalidId {
                    let nsEncoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding)
                    return String.Encoding(rawValue: nsEncoding)
                }
            }
            
            return data.stringEncoding ?? `default`
        }()
        
        self.init(data: data, encoding: encoding)
    }
    
    var asURL: URL? {
        return URL(string: self)
    }
}

extension Data {
    var stringEncoding: String.Encoding? {
        var nsString: NSString?
        guard case let rawValue = NSString.stringEncoding(for: self, encodingOptions: nil, convertedString: &nsString, usedLossyConversion: nil), rawValue != 0 else { return nil }
        return String.Encoding(rawValue: rawValue)
    }
}

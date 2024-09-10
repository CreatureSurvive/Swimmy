//
//  MultipartFormDataRequest.swift
//  Arctic
//
//  Created by Dana Buehre on 7/9/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL
    
    public private(set) var rawByteCount: Int = 0
    public var requestByteCount: Int { return httpBody.count }

    init(url: URL) {
        self.url = url
    }
    
    init(url: URL, fieldName name: String, data: Data, mimeType: String) {
        self.url = url
        self.addDataField(named: name, data: data, mimeType: mimeType)
    }

    mutating func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }

    private mutating func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    mutating func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }

    private mutating func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()

        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"image.jpg\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        
        appendByteCount(data.count)

        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data

        return request
    }
    
    mutating func appendByteCount(_ count: Int) {
        rawByteCount += count
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

//
//  APIExtensions.swift
//  
//
//  Created by Dana Buehre on 11/9/23.
//

import Foundation

//extension URL {
//    var isImageURL: Bool {
//        return absoluteString.isImageURL
//    }
//
//    var isVideoURL: Bool {
//        return absoluteString.isVideoURL
//    }
//}

//extension String {
//    
//    var nilOrValue: String? {
//        guard !isEmpty else {
//            return nil
//        }
//
//        return self
//    }
//    
//
//    var isImageURL: Bool {
//        return self.range(of: "(http[^\\s]+(jpg|jpeg|png|gif|gifv|webp|bmp|apng)\\b)", options: [.regularExpression, .caseInsensitive]) != nil
//    }
//
//    var isVideoURL: Bool {
//        return self.range(of: "(http[^\\s]+(avi|m4a|m4b|m4p|m4r|m4v|mov|mp4|mpa|mqv|webvtt|xhe|m3u8)\\b)", options: [.regularExpression, .caseInsensitive]) != nil
//    }
//
//    func getURLs(filterBlock: @escaping (URL) -> Bool) -> (found: [URL], filtered: [URL]) {
//        var urls: [URL] = []
//        var filtered: [URL] = []
//        let types: NSTextCheckingResult.CheckingType = [ .link]
//        let detector = try? NSDataDetector(types: types.rawValue)
//        detector?.enumerateMatches(in: self, options: [], range: NSMakeRange(0, (self as NSString).length)) { (result, flags, _) in
//            if let url = result?.url, url.scheme != "mailto" {
//                if filterBlock(url) {
//                    filtered.append(url)
//                } else {
//                    urls.append(url)
//                }
//            }
//        }
//        return (urls, filtered)
//    }
//
//    func getURLs(filter: String? = nil) -> (found: [URL], filtered: [URL]) {
//        var urls: [URL] = []
//        var filtered: [URL] = []
//        let types: NSTextCheckingResult.CheckingType = [ .link]
//        let detector = try? NSDataDetector(types: types.rawValue)
//        detector?.enumerateMatches(in: self, options: [], range: NSMakeRange(0, (self as NSString).length)) { (result, flags, _) in
//            if let url = result?.url, url.scheme != "mailto" {
//                if let filter = filter, url.absoluteString.contains(filter) {
//                    filtered.append(url)
//                } else {
//                    urls.append(url)
//                }
//            }
//        }
//        return (urls, filtered)
//    }
//
//    func getUniqueURLs(filterBlock: @escaping (URL) -> Bool) -> (found: [URL], filtered: [URL]) {
//        let results = getURLs(filterBlock: filterBlock)
//        return (results.found.uniqued(), results.filtered.uniqued())
//    }
//
//    func getUniqueURLs(filter: String? = nil) -> (found: [URL], filtered: [URL]) {
//        let results = getURLs(filter: filter)
//        return (results.found.uniqued(), results.filtered.uniqued())
//    }
//}

//extension Sequence where Element: Hashable {
//    func uniqued() -> [Element] {
//        var set = Set<Element>()
//        return filter { set.insert($0).inserted }
//    }
//}

//extension Post
//    var content: String? {
//        body ?? embed_description
//    }
//
//    var local_url: URL {
//        AccountManager.shared.instanceURL.appending(path: "post/\(id)")
//    }
//    
//    public var imageURL: URL? {
//        let url = url?.asURL
//        return (url?.isImageURL ?? false) ? url : nil
//    }
//    
//    public var videoURL: URL? {
//        let url = url?.asURL
//        return (url?.isVideoURL ?? false) ? url : nil
//    }
//    
//    public var imageURLs: [URL]? {
//        var urls = body?.getUniqueURLs().found.compactMap{ $0.isImageURL ? $0 : nil }
//        if let url = imageURL {
//            urls?.append(url)
//        }
//        
//        return urls
//    }
//    
//    public var videoURLs: [URL]? {
//        var urls = body?.getUniqueURLs().found.compactMap{ $0.isVideoURL ? $0 : nil }
//        if let url = videoURL {
//            urls?.append(url)
//        }
//        
//        return urls
//    }
//}
//

//extension Site {
//    var full_sidebar: String {
//        if let description = description?.nilOrValue, let sidebar = sidebar?.nilOrValue {
//            return "\(description)\n\n\(sidebar)"
//        }
//        if let description = description?.nilOrValue {
//            return description
//        }
//        if let sidebar = sidebar?.nilOrValue {
//            return sidebar
//        }
//        
//        return ""
//    }
//}

//extension Comment {
//    
//    var local_url: URL {
//        AccountManager.shared.instanceURL.appending(path: "comment/\(id)")
//    }
//    
//    var display_content: String {
//        deleted ? "*deleted by creator*" :
//        removed ? "*removed by mod*" :
//        content
//    }
//    
//    var parentId: Int? {
//        let components = path.components(separatedBy: ".")
//
//        guard path != "0", components.count != 2 else {
//            return nil
//        }
//
//        guard let id = components.dropLast(1).last else {
//            return nil
//        }
//
//        return Int(id)
//    }
//    
//    var pathIds: [Int]? {
//        let components = path.components(separatedBy: ".").dropFirst()
//        return components.compactMap({ Int($0) })
//    }
//    
//    var depth: Int {
//        let count = path.components(separatedBy: ".").count - 1
//        return count >= 0 ? count : 0
//    }
//    
//    var isTopLevel: Bool {
//        return depth < 2
//    }
//}

//extension Community {
//    var community_instance_name: String {
//        return "\(name)@\(URL(string: actor_id)!.host!)"
//    }
//    
//    var instance_host: String {
//        return URL(string: actor_id)!.host!
//    }
//    
//    var local_url: URL {
//        AccountManager.shared.instanceURL.appending(path: "c/\(community_instance_name)")
//    }
//}

//extension Person {
//    var instance: String {
//        return "\(actor_id.asURL!.host!)"
//    }
//    
//    var full_username: String {
//        return "\(name)@\(actor_id.asURL!.host!)"
//    }
//    
//    var safe_display_name: String {
//        return (!(display_name?.isEmpty ?? true) ? display_name : nil) ?? name
//    }
//}

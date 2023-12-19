//
//  APIExtensions.swift
//  
//
//  Created by Dana Buehre on 11/9/23.
//

import Foundation

// MARK: - Date Decoding

public protocol WithPublished {
    var published: String { get }
}

public extension WithPublished {
    var publishedDate: Date {
        return Date.date(string: published) ?? .init()
    }
}

public protocol WithUpdated {
    var updated: String? { get }
}

public extension WithUpdated {
    var updatedDate: Date? {
        guard let updated = updated else {
            return nil
        }
        return Date.date(string: updated)
    }
}

extension Comment: WithPublished, WithUpdated {}
extension CommentReply: WithPublished {}
extension CommentReport: WithPublished, WithUpdated {}
extension Community: WithPublished, WithUpdated {}
extension Instance: WithPublished, WithUpdated {}
extension LocalSite: WithPublished, WithUpdated {}
extension LocalSiteRateLimit: WithPublished, WithUpdated {}
extension Person: WithPublished, WithUpdated {}
extension PersonMention: WithPublished {}
extension Post: WithPublished, WithUpdated {}
extension PostReport: WithPublished, WithUpdated {}
extension PrivateMessage: WithPublished, WithUpdated {}
extension PrivateMessageReport: WithPublished, WithUpdated {}
extension RegistrationApplication: WithPublished {}
extension Site: WithPublished, WithUpdated {}
extension Tagline: WithPublished, WithUpdated {}

// MARK: - URL Decoding

public protocol WithApUrl {
    var ap_id: String { get }
}

public extension WithApUrl {
    var ap_id_url: URL {
        return URL(string: ap_id)!
    }
}

extension Comment: WithApUrl {}
extension Post: WithApUrl {}
extension PrivateMessage: WithApUrl {}

public protocol WithActorUrl {
    var actor_id: String { get }
}

public extension WithActorUrl {
    var actor_id_url: URL {
        return URL(string: actor_id)!
    }
}

extension Community: WithActorUrl {}
extension Person: WithActorUrl {}
extension Site: WithActorUrl {}


// MARK: - Post

public extension Post {
    
    var content: String? {
        body ?? embed_description
    }
    
    func localizedUrl(instanceUrl: URL) -> URL {
        instanceUrl.appending(path: "post/\(id)")
    }
}

extension PostView: Identifiable {
    public var id: Int {
        post.id
    }
}

// MARK: - Comment

public extension Comment {
    
    func localizedUrl(instanceUrl: URL) -> URL {
        instanceUrl.appending(path: "comment/\(id)")
    }
    
    var display_content: String {
        deleted ? "*deleted by creator*" :
        removed ? "*removed by mod*" :
        content
    }
    
    var parentId: Int? {
        let components = path.components(separatedBy: ".")

        guard path != "0", components.count != 2 else {
            return nil
        }

        guard let id = components.dropLast(1).last else {
            return nil
        }

        return Int(id)
    }
    
    var pathIds: [Int]? {
        let components = path.components(separatedBy: ".").dropFirst()
        return components.compactMap({ Int($0) })
    }
    
    var depth: Int {
        let count = path.components(separatedBy: ".").count - 1
        return count >= 0 ? count : 0
    }
    
    var isTopLevel: Bool {
        return depth < 2
    }
}

extension CommentView: Identifiable {
    public var id: Int {
        comment.id
    }
}

// MARK: - Community

public extension Community {
    
    func localizedUrl(instanceUrl: URL) -> URL {
        instanceUrl.appending(path: "c/\(community_instance_name)")
    }
    
    var community_instance_name: String {
        return "\(name)@\(URL(string: actor_id)!.host!)"
    }
    
    var instance_host: String {
        return URL(string: actor_id)!.host!
    }
}

extension CommunityView: Identifiable {
    public var id: Int {
        community.id
    }
}

// MARK: - Person

public extension Person {
    
    var instance: String {
        return "\(actor_id.asURL!.host!)"
    }
    
    var full_username: String {
        return "\(name)@\(actor_id.asURL!.host!)"
    }
    
    var safe_display_name: String {
        return (!(display_name?.isEmpty ?? true) ? display_name : nil) ?? name
    }
    
    var dynamicUsername: String {
        guard !local else {
            return name
        }
        
        return fullUsername
    }
    
    var fullUsername: String {
        guard let instance = actor_id_url.host else {
            return name
        }
        
        return "\(name)@\(instance)"
    }
}

extension PersonView: Identifiable {
    public var id: Int {
        person.id
    }
}

public extension GetUnreadCountResponse {
    var total: Int {
        replies + mentions + private_messages
    }
}

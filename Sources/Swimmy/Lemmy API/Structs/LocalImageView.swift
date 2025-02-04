//
//  LocalImageView.swift
//  Swimmy
//
//  Created by Dana Buehre on 2/3/25.
//

import Foundation

public struct LocalImageView: Codable, Hashable, Sendable {
    public let local_image: LocalImage
    public let person: Person

    public  init(local_image: LocalImage, person: Person) {
        self.local_image = local_image
        self.person = person
    }
}

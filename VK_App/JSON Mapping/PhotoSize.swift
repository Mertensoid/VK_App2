//
//  PhotoSizes.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct PhotoSize {
    let photoHeight: Int
    let photoURL: String
    let photoType: String
    let photoWidth: Int
}

extension PhotoSize: Codable {
    enum CodingKeys: String, CodingKey {
        case photoHeight = "height"
        case photoURL = "url"
        case photoType = "type"
        case photoWidth = "width"
    }
}

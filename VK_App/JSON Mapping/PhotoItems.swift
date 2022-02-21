//
//  PhotoItems.swift
//  VK_App
//
//  Created by admin on 21.02.2022.
//

struct PhotoItems {
    let photos: [PhotoData]
}
extension PhotoItems: Codable {
    enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}

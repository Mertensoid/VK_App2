//
//  PhotoData.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct PhotoData {
    let photoID: Int
    let ownerID: Int
    let photoSizes: [PhotoSize]
}

extension PhotoData: Codable {
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case ownerID = "owner_id"
        case photoSizes = "sizes"
    }
}

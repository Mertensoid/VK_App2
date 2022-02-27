//
//  PhotoData.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct PhotoData {
    //let albumID: Int
    //let date: String
    let photoID: Int
    let ownerID: Int
    //let postID: Int
    let photoSizes: [PhotoSize]
    //let photoText: String
    //let hasTags: Bool
}

extension PhotoData: Codable {
    enum CodingKeys: String, CodingKey {
        //case albumID = "album_id"
        //case date
        case photoID = "id"
        case ownerID = "owner_id"
        //case postID = "post_id"
        case photoSizes = "sizes"
        //case photoText = "text"
        //case hasTags = "has_tags"
    }
}

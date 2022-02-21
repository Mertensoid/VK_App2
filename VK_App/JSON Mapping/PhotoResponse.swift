//
//  PhotoResponse.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct PhotoResponse {
    let response: PhotoItems
}
extension PhotoResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

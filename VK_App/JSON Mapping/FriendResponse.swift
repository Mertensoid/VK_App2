//
//  UserArrayData.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct FriendResponse {
    let users: [FriendData]
}

extension FriendResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

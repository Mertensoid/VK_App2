//
//  FriendItems.swift
//  VK_App
//
//  Created by admin on 20.02.2022.
//

struct FriendItems {
    let friends: [FriendData]
}

extension FriendItems: Codable {
    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}

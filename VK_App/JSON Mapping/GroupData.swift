//
//  GroupData.swift
//  VK_App
//
//  Created by admin on 21.02.2022.
//

import UIKit

struct GroupData {
    let groupID: Int
    let groupName: String
    let groupPic: String
}

extension GroupData: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case groupID = "id"
        case groupName = "name"
        case groupPic = "photo_100"
    }
}

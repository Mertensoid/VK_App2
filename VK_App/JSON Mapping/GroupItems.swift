//
//  GroupItems.swift
//  VK_App
//
//  Created by admin on 20.02.2022.
//


//TODO: Изменить структуру данных с учетом extended=1
struct GroupItems {
    let groupData: [GroupData]
}

extension GroupItems: Codable {
    enum CodingKeys: String, CodingKey {
        case groupData = "items"
    }
}

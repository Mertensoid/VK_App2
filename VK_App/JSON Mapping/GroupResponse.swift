//
//  GroupData.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

//TODO: Изменить структуру данных с учетом extended=1
struct GroupResponse {
    let response: GroupItems
}

extension GroupResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

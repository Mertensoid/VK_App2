//
//  NewsItems.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsItems {
    let items: [NewsData]
    let nextFrom: String
}

extension NewsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"
    }
}

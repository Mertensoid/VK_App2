//
//  NewsItems.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsItems {
    let items: [NewsData]
}

extension NewsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case items
    }
}

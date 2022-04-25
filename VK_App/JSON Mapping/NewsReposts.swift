//
//  NewsReposts.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsReposts {
    let count: Int
}

extension NewsReposts: Codable {
    enum CodingKeys: String, CodingKey {
        case count
    }
}

//
//  NewsLikes.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsLikes {
    let likes: Int
}

extension NewsLikes: Codable {
    enum CodingKeys: String, CodingKey {
        case likes = "count"
    }
}

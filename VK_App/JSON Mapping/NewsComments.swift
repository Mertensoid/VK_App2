//
//  NewComments.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsComments {
    let commentsCount: Int
}

extension NewsComments: Codable {
    enum CodingKeys: String, CodingKey {
        case commentsCount = "count"
    }
}

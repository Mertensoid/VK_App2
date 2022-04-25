//
//  NewsResponse.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsResponse {
    let response: NewsItems
}

extension NewsResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

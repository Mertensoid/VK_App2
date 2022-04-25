//
//  NewsAttachments.swift
//  VK_App
//
//  Created by admin on 09.04.2022.
//

import Foundation

struct NewsAttachments {
    let type: String
    let link: NewsLink?
    let photo: PhotoData?
}

extension NewsAttachments: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case link
        case photo
    }
}

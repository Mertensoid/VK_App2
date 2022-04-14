//
//  NewsLink.swift
//  VK_App
//
//  Created by admin on 09.04.2022.
//

import Foundation

struct NewsLink {
    let photo: PhotoData?
}

extension NewsLink: Codable {
    enum CodingKeys: String, CodingKey {
        case photo
    }
}

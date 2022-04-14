//
//  NewsPhotos.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsPhotos {
    let photoID: String
    let src: String
    let srcBig: String
}

extension NewsPhotos: Codable {
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case src
        case srcBig = "src_big"
    }
}

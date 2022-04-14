//
//  NewsData.swift
//  VK_App
//
//  Created by admin on 08.04.2022.
//

import Foundation

struct NewsData {
    let sourceID: Int
    let date: Int
    let text: String?
    let comments: NewsComments
    let likes: NewsLikes
    let reposts: NewsReposts
    let attachments: [NewsAttachments]?
    var sourceName: String = ""
    var sourcePic: String = ""
}

extension NewsData: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case comments
        case likes
        case reposts
        case attachments
        
    }
}



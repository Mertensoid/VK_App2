//
//  VKResponse.swift
//  VK_App
//
//  Created by admin on 02.03.2022.
//

import Foundation

struct VKResponse<T:Codable>: Codable {
    var response: T
 
    enum CodingKeys: String, CodingKey {
        case response
    }
}

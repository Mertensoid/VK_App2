//
//  SessionSingleton.swift
//  VK_App
//
//  Created by admin on 12.02.2022.
//

import Foundation

class SessionSingleton {
    var token: String = ""
    var userId: Int = 0
    
    static let instance = SessionSingleton()
    
    private init() {
        
    }
}

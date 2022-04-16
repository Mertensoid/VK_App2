//
//  Promises.swift
//  VK_App
//
//  Created by admin on 16.04.2022.
//

import Foundation
import PromiseKit

class PromisesService {
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func getURL() -> Promise<URL> {
        
        let requestComponents: URLComponents = {
            var comp = URLComponents()
            comp.scheme = "https"
            comp.host = "api.vk.com"
            comp.path = "/method/groups.get"
            comp.queryItems = [
                URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId))
            ]
            return comp
        }()
        
        return Promise { resolver in
            guard let url = requestComponents.url else {
                resolver.reject(Errors.incorrectURL)
                return
            }
            resolver.fulfill(url)
        }
    }
    
    func getData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    resolver.reject(Errors.incorrectTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func getGroups(_ data: Data) -> Promise<[GroupData]> {
        return Promise { resolver in
            do {
                let groups = try JSONDecoder().decode(GroupResponse.self, from: data).response.groupData
                resolver.fulfill(groups)
            } catch {
                resolver.reject(Errors.incorrectData)
            }
        }
    }
    
    func saveGroups(_ groups: [GroupData]) -> Promise<[RealmGroups]> {
        return Promise { resolver in
            let realmGroups = groups.map { RealmGroups(group: $0) }
            try? RealmService.save(items: realmGroups)
            resolver.fulfill(realmGroups)
            
        }
    }
}


//
//  NetworkService.swift
//  VK_App
//
//  Created by admin on 17.02.2022.
//

import UIKit

class NetworkService {
    
    //let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    let friendsRequestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/friends.get"
        comp.queryItems = [
            URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId)),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "bdate"),
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return comp
    }()
    
    let userPhotoRequestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/photos.getAll"
        comp.queryItems = [
            URLQueryItem(name: "owner_id", value: String(SessionSingleton.instance.userId)),
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return comp
    }()
    
    let userGroupsRequestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/groups.get"
        comp.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId)),
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return comp
    }()
    
    let searchGroupsRequestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/groups.search"
        comp.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return comp
    }()
    
//    let searchGroupsTask = session.dataTask(with: searchGroupsRequestComponents.url!) { (data, response, error) in
//        let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//        print(json)
//    }
//
//    searchGroupsTask.resume()
    
    
    func fetchFriends(completion: @escaping (Result<[FriendData], Error>) -> Void) {
        
        guard let url = friendsRequestComponents.url else { return }
        
        let getFriendsTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            do {
                let friendResponse = try JSONDecoder().decode(FriendResponse.self, from: data)
                completion(.success(friendResponse.response.friends))
            } catch {
                completion(.failure(error))
            }
        }
        getFriendsTask.resume()
    }
    
    func fetchPhotos(completion: @escaping (Result<[FriendData], Error>) -> Void) {
        
        guard let url = userPhotoRequestComponents.url else { return }
        
        let getPhotosTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            do {
                let friendResponse = try JSONDecoder().decode(FriendResponse.self, from: data)
                completion(.success(friendResponse.response.friends))
            } catch {
                completion(.failure(error))
            }
        }
        getPhotosTask.resume()
    }
    
    func fetchGroups(completion: @escaping (Result<[GroupData], Error>) -> Void) {
        
        guard let url = userGroupsRequestComponents.url else { return }
        
        let getGroupsTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            do {
                let groupResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                completion(.success(groupResponse.response.groupData))
            } catch {
                completion(.failure(error))
            }
        }
        getGroupsTask.resume()
    }
    
    
    func fetchGroups(urlQI: URLQueryItem, completion: @escaping (Result<[GroupData], Error>) -> Void) {
        var comp = searchGroupsRequestComponents
        comp.queryItems?.insert(urlQI, at: 0)
        guard let url = comp.url else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            do {
                let groupResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                completion(.success(groupResponse.response.groupData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
//    func fetchGroups(completion: @escaping (Result<[Int], Error>) -> Void) {
//
//        guard let url = userGroupsRequestComponents.url else { return }
//
//        let getGroupsTask = session.dataTask(with: url) { (data, response, error) in
//            guard
//                let response = response as? HTTPURLResponse,
//                error == nil,
//                let data = data
//            else { return }
//            do {
//                let groupResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
//                completion(.success(groupResponse.response.groupID))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        getGroupsTask.resume()
//    }
}

//
//  NetworkService.swift
//  VK_App
//
//  Created by admin on 17.02.2022.
//

import UIKit

class NetworkService {
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    let friendsRequestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/friends.get"
        comp.queryItems = [
            URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId)),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "order", value: "name"),
            //URLQueryItem(name: "fields", value: "bdate"),
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
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return comp
    }()

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
    
    func fetchPhotos(urlQI: URLQueryItem, completion: @escaping (Result<[PhotoData], Error>) -> Void) {
        
        var comp = userPhotoRequestComponents
        comp.queryItems?.insert(urlQI, at: 0)
        guard let url = comp.url else { return }
        
        let getPhotosTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            do {
                let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
                completion(.success(photoResponse.response.photos))
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
    
    
    func searchGroups(urlQI: URLQueryItem, completion: @escaping (Result<[GroupData], Error>) -> Void) {
        
        var comp = searchGroupsRequestComponents
        
        if let search = urlQI.value {
            if !search.isEmpty {
                comp.queryItems?.insert(urlQI, at: 0)
            } else {
                //comp.queryItems?.insert(URLQueryItem(name: "q", value: "a"), at: 0)
            }
        }
        
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
}

//
//  File.swift
//  VK_App
//
//  Created by admin on 16.04.2022.
//

import Foundation
import Alamofire

//Класс асинхронной операции, от которого будут наследоваться операции с конкретными действиями
class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
}
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    override var isAsynchronous: Bool {
        return true
    }
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
    }
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    override func cancel() {
        super.cancel()
        state = .finished
    }
}

// Операция загрузки друзей из VK API
class LoadFriedsOperation: Operation {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    var loadedData: Any?

    let requestComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.vk.com"
        comp.path = "/method/friends.get"
        comp.queryItems = [
            URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId)),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "order", value: "name")
        ]
        return comp
    }()
    
    func loadFriends() {
        
        guard let url = requestComponents.url else { return }
        let getFriendsTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let _ = response as? HTTPURLResponse,
                error == nil,
                let data = data
            else { return }
            self.loadedData = try? JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments)
        }
        getFriendsTask.resume()
    }
    
    override func main() {
        print("Начало операции загрузки")
        loadFriends()
        print("Конец операции загрузки")
    }
}

// Операция парсинга JSON в массив FriendsData
class ParseFriedsOperation: Operation {
    
    //var data: Any?
    var friendsVK: [FriendData] = []
    
//    init(dataForParsing: Any?) {
//        self.data = dataForParsing
//        super.init()
//    }
    
    override func main() {
        print("Начало операции парсинга")
        guard let previousOperation = dependencies.first as? LoadFriedsOperation else { return }
        do {
            if let data = previousOperation.loadedData as? Data {
                friendsVK = try JSONDecoder().decode([FriendData].self, from: data)
            }
        } catch {
            print(error)
        }
        print("Конец операции парсинга")
    }
}

// Операция сохранения FriendsData в Realm
class SaveFriendsOperation: Operation {
//    var friends: [FriendData]
//
//    init(friendsToRealm: [FriendData]) {
//        self.friends = friendsToRealm
//        super.init()
//    }
    
    var realmFriends: [RealmFriends] = []
    
    override func main() {
        print("Начало операции сохранения")
        guard let previousOperation = dependencies.first as? ParseFriedsOperation else { return }
        let friends = previousOperation.friendsVK
        realmFriends = friends.map { RealmFriends(friend: $0) }
        try? RealmService.save(items: realmFriends)
        print("Конец операции сохранения")
    }
}




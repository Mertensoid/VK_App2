//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var myFriends = generateMyFriends()
    var currentFriend: User? = nil
    var sortedFriends: [Character: [User]] = [:]
    var sortedFriendsChars: [Character] = []
    let alphabet: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    
    
    func sortFriends(friends: [User]) {
        for currentChar in alphabet {
            var currentCharFriends: [User] = []
            for i in friends {
                if i.userName.hasPrefix(String(currentChar)) {
                    currentCharFriends.append(i)
                }
            }
            if !currentCharFriends.isEmpty {
                sortedFriends[currentChar] = currentCharFriends
                sortedFriendsChars.append(currentChar)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(
                nibName: "UserTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "userTableViewCell")
        
        sortFriends(friends: myFriends)
        print(sortedFriends)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
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
                URLQueryItem(name: "user_id", value: String(SessionSingleton.instance.userId)),
                URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
                URLQueryItem(name: "v", value: "5.131"),
            ]
            return comp
        }()
        
        let getFriendsTask = session.dataTask(with: friendsRequestComponents.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        
        let getPhotosTask = session.dataTask(with: userPhotoRequestComponents.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        
        let getGroupsTask = session.dataTask(with: userGroupsRequestComponents.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        
        getFriendsTask.resume()
        getPhotosTask.resume()
        getGroupsTask.resume()
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToFriendsPhotoCollection" else { return }
        guard let destination = segue.destination as? PhotoCollectionViewController else { return }
        if let user = currentFriend {
            destination.user = user
        }
        else { return }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedFriends.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfFriends = sortedFriends[sortedFriendsChars[section]]?.count {
            return numberOfFriends
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedFriendsChars[section])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as? UserTableViewCell
        else { return UITableViewCell() }
        
        let currentUser = sortedFriends[sortedFriendsChars[indexPath.section]]?[indexPath.row]
        cell.configView(user: currentUser!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        currentFriend = sortedFriends[sortedFriendsChars[indexPath.section]]?[indexPath.row]
        performSegue(withIdentifier: "goToFriendsPhotoCollection", sender: nil)
    }

}


//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    private var myFriends = [FriendData]() {
        didSet {
            DispatchQueue.main.async {
                self.sortFriends(friends: self.myFriends)
                self.tableView.reloadData()
            }
        }
    }
    var currentFriend: FriendData? = nil
    var sortedFriends: [Character: [FriendData]] = [:]
    var sortedFriendsChars: [Character] = []
    let alphabet: [Character] = ["А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "К", "Л", "М", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ы", "Э", "Ю", "Я", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    private let networkService = NetworkService()
    private var friends: [FriendData] = []
    
    
    func sortFriends(friends: [FriendData]) {
        for currentChar in alphabet {
            var currentCharFriends: [FriendData] = []
            for i in friends {
                if i.surName.hasPrefix(String(currentChar)) {
                    currentCharFriends.append(i)
                }
            }
            if !currentCharFriends.isEmpty {
                sortedFriends[currentChar] = currentCharFriends
                sortedFriendsChars.append(currentChar)
            }
        }
        print(sortedFriends)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(
                nibName: "UserTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "userTableViewCell")
        
        networkService.fetchFriends() { [weak self] result in
            switch result {
            case .success(let friends):
                self?.myFriends = friends
                //print(self?.myFriends)
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToFriendsPhotoCollection" else { return }
        guard let destination = segue.destination as? PhotoCollectionViewController else { return }
        if let user = currentFriend {
            destination.user = user.friendID
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


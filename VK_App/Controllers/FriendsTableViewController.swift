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

//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {

    private var myFriends: Results<RealmFriends>? = try? RealmService.load(typeOf: RealmFriends.self)
    private var sortedRealmFriends: [Character: Results<RealmFriends>] = [:]

    private var currentFriend: Int = 0
    private var sortedFriends: [Character: [FriendData]] = [:]
    private var sortedFriendsChars: [Character] = []
    private let alphabet: [Character] = ["А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "К", "Л", "М", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ы", "Э", "Ю", "Я", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private let networkService = NetworkService()

    private var friends: [FriendData] = []
    
    func sortRealmFriends(friend: Results<RealmFriends>) {
        for i in alphabet {
                let currentCharFriends = friend.filter { $0.surName.hasPrefix(String(i)) }
            if !currentCharFriends.isEmpty {
                sortedFriendsChars.append(i)
                //sortedRealmFriends[i] = currentCharFriends
            }
        }
    }
//    func sortFriends(friends: Results<RealmFriends>) {
//        for currentChar in alphabet {
//            var currentCharFriends: Results<RealmFriends> = friends
//            for i in friends {
//                if i.surName.hasPrefix(String(currentChar)) {
//                    currentCharFriends.append(i)
//                }
//            }
//            if !currentCharFriends.isEmpty {
//                sortedFriends[currentChar] = currentCharFriends
//                sortedFriendsChars.append(currentChar)
//            }
//        }
//        print(sortedFriends)
//    }

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
                let realmFriends = friends.map { RealmFriends(
                    friend: $0) }
                DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: realmFriends)
                        self?.myFriends = try RealmService.load(typeOf: RealmFriends.self)
                        self?.tableView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToFriendsPhotoCollection" else { return }
        guard let destination = segue.destination as? PhotoCollectionViewController else { return }
        destination.user = currentFriend
    }
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sortedFriends.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let numberOfFriends = sortedFriends[sortedFriendsChars[section]]?.count {
//            return numberOfFriends
//        } else {
//            return 0
//        }
        return myFriends?.count ?? 0
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(sortedFriendsChars[section])
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let currentFriend = myFriends?[indexPath.row],

            //let currentUser = sortedFriends[sortedFriendsChars[indexPath.section]]?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as? UserTableViewCell
        else { return UITableViewCell() }
        
        cell.configView(currentFriend)
        //cell.configView(user: currentUser)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        if let userID = myFriends?[indexPath.row].friendID {
            currentFriend = userID
        }
        
        //sortedFriends[sortedFriendsChars[indexPath.section]]?[indexPath.row]
        performSegue(withIdentifier: "goToFriendsPhotoCollection", sender: nil)
    }

}


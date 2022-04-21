//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {

    // MARK: - Private properties
    private var myFriends: Results<RealmFriends>? = try? RealmService.load(typeOf: RealmFriends.self)
    private var sortedRealmFriends: [Character: Results<RealmFriends>] = [:]
    private var friendsToken: NotificationToken?
    private var currentFriend: Int = 0
    private var sortedFriends: [Character: [FriendData]] = [:]
    private var sortedFriendsChars: [Character] = []
    private let alphabet: [Character] = ["А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "К", "Л", "М", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ы", "Э", "Ю", "Я", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    private let networkService = NetworkService()
    private var photoService: PhotoService?
    private var friends: [FriendData] = []
    
    //MARK: - IBOutlet, IBAction
    @IBAction func addFriendWithAlert(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Enter friend name",
            message: "Add",
            preferredStyle: .alert)
        alertController.addTextField { _ in }
        
        let confirm = UIAlertAction(
            title: "Add",
            style: .default) { action in
                guard let name = alertController.textFields?.first?.text else { return }
                self.addNewFriend(name: name)
            }
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .default,
            handler: nil)
        
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        present(
            alertController,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Private methods
    private func addNewFriend(name: String){
        let friend = RealmFriends()
        friend.name = name
        friend.friendPhoto = "123"
        friend.surName = name + "Surname"
        try? RealmService.save(items: [friend])
    }
 
    private func sortRealmFriends(friend: Results<RealmFriends>) {
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
    
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: tableView)
        
        tableView.register(
            UINib(
                nibName: "UserTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "userTableViewCell")
        
        let opq = OperationQueue()
        
        let loadOperation = LoadFriedsOperation()
        opq.addOperation(loadOperation)
        
        let parseOperation = ParseFriedsOperation()
        parseOperation.addDependency(loadOperation)
        opq.addOperation(parseOperation)
        
        let saveOperation = SaveFriendsOperation()
        saveOperation.addDependency(parseOperation)
        saveOperation.completionBlock = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        opq.addOperation(saveOperation)
        
//        networkService.fetchFriends() { [weak self] result in
//            switch result {
//            case .success(let friends):
//                let realmFriends = friends.map { RealmFriends(
//                    friend: $0) }
//                DispatchQueue.main.async {
//                    do {
//                        try RealmService.save(items: realmFriends)
//                        self?.myFriends = try RealmService.load(typeOf: RealmFriends.self)
//                        self?.tableView.reloadData()
//                    } catch {
//                        print(error)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        friendsToken = myFriends?.observe { [weak self] myFriendsChanges in
            guard let self = self else { return }
            switch myFriendsChanges {
            case .initial:
                self.tableView.reloadData()
            case .update(
                _,
                deletions: let deletions,
                insertions: let insertions,
                modifications: let modifications):
                self.tableView.beginUpdates()
                let delRowsIndex = deletions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let insertRowsIndex = insertions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let modificationRowsIndex = modifications.map { IndexPath(
                    row: $0,
                    section: 0) }
                self.tableView.deleteRows(
                    at: delRowsIndex,
                    with: .automatic)
                self.tableView.insertRows(
                    at: insertRowsIndex,
                    with: .automatic)
                self.tableView.reloadRows(
                    at: modificationRowsIndex,
                    with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        friendsToken?.invalidate()
    }
    
    //MARK: - Segue data source
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as? UserTableViewCell
        else { return UITableViewCell() }
        let userName = currentFriend.surName + " " + currentFriend.name
        let userPic = photoService?.photo(atIndexPath: indexPath, byURL: currentFriend.friendPhoto) ?? UIImage()
        cell.config(userName: userName, userPic: userPic)
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


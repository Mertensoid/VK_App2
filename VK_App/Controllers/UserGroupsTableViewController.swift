//
//  UserGroupsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import Foundation
import UIKit
import RealmSwift
import PromiseKit

class UserGroupsTableViewController: UITableViewController {

    //MARK: - IBOutlet, IBAction
    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        guard
//            segue.identifier == "addGroup",
//            let findGroupController = segue.source as? FindGroupsTableViewController,
//            let groupIndexPath = findGroupController.tableView.indexPathForSelectedRow
//            !userGroups.contains(findGroupController.allGroups[groupIndexPath.row])
//        else { return }
//        self.userGroups.append(findGroupController.allGroups[groupIndexPath.row])
        self.tableView.reloadData()
    }
    
    //MARK: - Private properties
    private let networkService = NetworkService()
    private let promisesService = PromisesService()
    private var userGroups: Results<RealmGroups>? = try? RealmService.load(typeOf: RealmGroups.self)
    private var groupsToken: NotificationToken?
    private var photoService: PhotoService?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: tableView)
        
        tableView.register(
            UINib(
                nibName: "GroupsTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "groupsTableViewCell")
        
        promisesService.getURL()
            .then(on: .global(), promisesService.getData(_:))
            .then(promisesService.getGroups(_:))
            .then(promisesService.saveGroups(_:))
            .done(on: .main) { news in
                print(news)
            }.catch { error in
                print(error)
            }
        
        
//        networkService.fetchGroups() { [weak self] result in
//            switch result {
//            case .success(let groups):
//                let realmGroups = groups.map {
//                    RealmGroups(group: $0)
//                }
//                DispatchQueue.main.async {
//                    do {
//                        try RealmService.save(items: realmGroups)
//                        self?.userGroups = try RealmService.load(typeOf: RealmGroups.self)
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
        groupsToken = userGroups?.observe { [weak self] userGroupsChanges in
            guard let self = self else { return }
            switch userGroupsChanges {
            case .initial:
                self.tableView.reloadData()
            case .update(
                _,
                deletions: let deletions,
                insertions: let insertions,
                modifications: let modifications):
                self.tableView.beginUpdates()
                let deleteIndex = deletions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let insertIndex = insertions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let modificationIndex = modifications.map { IndexPath(
                    row: $0,
                    section: 0) }
                self.tableView.deleteRows(
                    at: deleteIndex,
                    with: .automatic)
                self.tableView.insertRows(
                    at: insertIndex,
                    with: .automatic)
                self.tableView.reloadRows(
                    at: modificationIndex,
                    with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
                    
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        groupsToken?.invalidate()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            userGroups.remove(at: indexPath.row )
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let currentGroup = userGroups?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
        let image = photoService?.photo(atIndexPath: indexPath, byURL: currentGroup.groupPic)
        cell.config(groupName: currentGroup.groupName, groupPic: image ?? UIImage())
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}

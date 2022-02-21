//
//  UserGroupsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import Foundation
import UIKit

class UserGroupsTableViewController: UITableViewController {

    var userGroups = [GroupData]()
//    {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        guard
            segue.identifier == "addGroup",
            let findGroupController = segue.source as? FindGroupsTableViewController,
            let groupIndexPath = findGroupController.tableView.indexPathForSelectedRow,
            !userGroups.contains(findGroupController.allGroups[groupIndexPath.row])
                
        else { return }
        self.userGroups.append(findGroupController.allGroups[groupIndexPath.row])
        self.tableView.reloadData()
        
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row )
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: "GroupsTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "groupsTableViewCell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
        
        let currentGroup = userGroups[indexPath.row]
        cell.configure(group: currentGroup)
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}

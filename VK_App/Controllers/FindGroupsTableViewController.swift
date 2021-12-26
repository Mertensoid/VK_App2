//
//  FindGroupsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {

    
    var allGroups = generateMyGroups()
    
    
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
        return allGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
        
        let currentGroup = allGroups[indexPath.row]
        cell.configure(group: currentGroup)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        performSegue(withIdentifier: "addGroup", sender: nil)
    }
    
    

}

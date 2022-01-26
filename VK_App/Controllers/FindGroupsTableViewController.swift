//
//  FindGroupsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {

    
    var allGroups = generateMyGroups()
    var sortedGroups: [Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: "GroupsTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "groupsTableViewCell")
        sortedGroups = allGroups
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "groupsTableViewCell",
                for: indexPath)
                as? GroupsTableViewCell
        else { return UITableViewCell() }
        
        let currentGroup = sortedGroups[indexPath.row]
        cell.configure(group: currentGroup)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.tableView.deselectRow(
                at: indexPath,
                animated: true)
        }
        performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }
}

extension FindGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortedGroups = []
        for i in allGroups {
            if i.groupName.hasPrefix(searchText) {
                sortedGroups.append(i)
            }
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sortedGroups = allGroups
        searchBar.endEditing(true)
    }
}

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
    var glassView = UIImageView()
    var textField = UITextField()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = UIView(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: self.tableView.frame.width,
                height: 40))
        self.tableView.tableHeaderView = headerView
        
        textField = UITextField(frame: CGRect(x: 5, y: 5, width: headerView.frame.width - 10, height: 30))
        textField.backgroundColor = UIColor.systemGray6
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        headerView.addSubview(textField)
        
        glassView = UIImageView(frame: CGRect(x: headerView.frame.width / 2 - 12, y: headerView.frame.height / 2 - 12, width: 24, height: 24))
        glassView.image = UIImage(systemName: "magnifyingglass")
        headerView.addSubview(glassView)
        
        cancelButton = UIButton(frame: CGRect(x: headerView.frame.width - 35, y: 5, width: 30, height: 30))
        cancelButton.setImage(UIImage(systemName: "clear"), for: .normal)
        cancelButton.layer.opacity = 0.0
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked(_:)), for: .touchUpInside)
        headerView.addSubview(cancelButton)
        
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

extension FindGroupsTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.transition(
            with: glassView,
            duration: 0.5,
            options: .curveLinear,
            animations: {
                self.textField.frame.size.width -= 60
                self.textField.frame.origin.x += 30
                self.cancelButton.isHidden = false
                self.cancelButton.layer.opacity = 1
            },
            completion: nil)
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.7,
            options: .curveLinear,
            animations: {
                self.glassView.frame.origin.x = 5
            },
            completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.transition(
            with: glassView,
            duration: 0.5,
            options: .curveLinear,
            animations: {
                self.textField.frame.size.width += 60
                self.textField.frame.origin.x -= 30
                
                self.cancelButton.layer.opacity = 0.0
            },
            completion: {_ in self.cancelButton.isHidden = true})
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.7,
            options: .curveLinear,
            animations: {
                self.glassView.frame.origin.x = self.tableView.tableHeaderView!.frame.width / 2 - 12
            },
            completion: nil)
    }
    
    @objc
    func cancelButtonClicked(_ button: UIButton) {
        sortedGroups = allGroups
        textField.endEditing(true)
    }
    
    @objc
    func textFieldDidChanged(_ textField: UITextField) {
        sortedGroups = []
        for i in allGroups {
            let tempString = textField.text
            if i.groupName.hasPrefix(tempString!) {
                sortedGroups.append(i)
            }
        }
        tableView.reloadData()
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let searchGroupsRequestComponents: URLComponents = {
            var comp = URLComponents()
            comp.scheme = "https"
            comp.host = "api.vk.com"
            comp.path = "/method/groups.search"
            comp.queryItems = [
                URLQueryItem(name: "q", value: textField.text),
                URLQueryItem(name: "count", value: "10"),
                URLQueryItem(name: "access_token", value: SessionSingleton.instance.token),
                URLQueryItem(name: "v", value: "5.131"),
            ]
            return comp
        }()
        
        let searchGroupsTask = session.dataTask(with: searchGroupsRequestComponents.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        
        searchGroupsTask.resume()
    }
}

//extension FindGroupsTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        sortedGroups = []
//        for i in allGroups {
//            if i.groupName.hasPrefix(searchText) {
//                sortedGroups.append(i)
//            }
//        }
//        tableView.reloadData()
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        sortedGroups = allGroups
//        searchBar.endEditing(true)
//    }
//}

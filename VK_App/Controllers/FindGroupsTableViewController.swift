//
//  FindGroupsTableViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {

    //MARK: - Private properties
    private var allGroups: [GroupData] = []
    private var sortedGroups: [GroupData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var glassView = UIImageView()
    private var textField = UITextField()
    private var cancelButton = UIButton()
    private let networkService = NetworkService()
    
    //MARK: - Lifecycle
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
        
        let urlQI = URLQueryItem(name: "q", value: textField.text)
        networkService.searchGroups(urlQI: urlQI) { [weak self] result in
            switch result {
            case .success(let groups):
                //TODO: Заменить структуру sortedGroups новой структурой данных из JSON
                self?.allGroups = groups
                self?.sortedGroups = self!.allGroups
            case .failure(let error):
                print(error)
            }
        }

        tableView.register(
            UINib(
                nibName: "GroupsTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "groupsTableViewCell")
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

        let urlQI = URLQueryItem(name: "q", value: textField.text)
        networkService.searchGroups(urlQI: urlQI) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.allGroups = groups
                self?.sortedGroups = self!.allGroups
            case .failure(let error):
                print(error)
            }
        }
    }
}

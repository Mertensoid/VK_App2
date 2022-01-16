//
//  UsersTableViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    @IBOutlet weak var groupPic: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    func configure(group: Group) {
        groupPic.image = group.groupPic
        groupName.text = group.groupName
    }
}

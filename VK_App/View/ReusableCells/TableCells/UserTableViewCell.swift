//
//  UserTableViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    func configure(user: User) {
        userPic.image = user.avatarPic
        userName.text = user.userName
    }
    
}

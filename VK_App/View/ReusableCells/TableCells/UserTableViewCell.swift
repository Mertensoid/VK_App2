//
//  UserTableViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var currentAvatarView: AvatarView!
    @IBOutlet weak var userName: UILabel!

    
    func configView(user: User) {

        
        userName.text = user.userName
        
        currentAvatarView.addSubview(currentAvatarShadow)
        currentAvatarView.addSubview(currentAvatarPic)
        
        currentAvatarShadow.layer.borderColor = UIColor.red.cgColor
        currentAvatarShadow.layer.borderWidth = 64.0
        currentAvatarShadow.layer.cornerRadius = currentAvatarPic.frame.height / 2
        currentAvatarShadow.layer.shadowColor = currentAvatarView.shadowColor.cgColor
        currentAvatarShadow.layer.shadowOffset = currentAvatarView.shadowOffset
        currentAvatarShadow.layer.shadowOpacity = currentAvatarView.shadowOpasity
        currentAvatarShadow.layer.shadowRadius = 5

        currentAvatarPic.image = user.avatarPic
        currentAvatarPic.layer.cornerRadius = currentAvatarPic.frame.height / 2
        currentAvatarPic.clipsToBounds = true
    }
    
    //var currentAvatarView: AvatarView = AvatarView(frame: CGRect(x: 10.0, y: 10.0, width: 128.0, height: 128.0))
    
    var currentAvatarPic: AvatarPicView = AvatarPicView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
    var currentAvatarShadow: AvatarShadowView = AvatarShadowView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
}

class AvatarView: UIView {
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 5, height: 5)
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpasity: Float = 1.0
}

class AvatarPicView: UIImageView {
    override class var layerClass: AnyClass {
        CALayer.self
    }
    
}

class AvatarShadowView: UIView {
    override class var layerClass: AnyClass {
        CALayer.self
    }

}

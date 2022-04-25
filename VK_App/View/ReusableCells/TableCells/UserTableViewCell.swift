//
//  UserTableViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var currentAvatarView: AvatarView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var currentAvatarShadow: UIView!
    @IBOutlet weak var currentAvatarPic: UIImageView!
    
    override func prepareForReuse() {
        currentAvatarView.addSubview(currentAvatarShadow)
        currentAvatarView.addSubview(currentAvatarPic)
        currentAvatarView.isUserInteractionEnabled = true
        currentAvatarPic.isUserInteractionEnabled = true
        currentAvatarShadow.isUserInteractionEnabled = true
        currentAvatarShadow.layer.borderColor = UIColor.red.cgColor
        currentAvatarShadow.layer.borderWidth = 60.0
        currentAvatarShadow.layer.cornerRadius = currentAvatarPic.frame.height / 2
        currentAvatarShadow.layer.shadowColor = currentAvatarView.shadowColor.cgColor
        currentAvatarShadow.layer.shadowOffset = currentAvatarView.shadowOffset
        currentAvatarShadow.layer.shadowOpacity = currentAvatarView.shadowOpasity
        currentAvatarShadow.layer.shadowRadius = 10
        currentAvatarPic.layer.cornerRadius = currentAvatarPic.frame.height / 2
        currentAvatarPic.clipsToBounds = true
        currentAvatarView.layer.cornerRadius = currentAvatarView.frame.height / 2
    }
    
    func configView(_ user: FriendData) {
        userName.text = user.surName + " " + user.name
        let imageUrlString = user.friendPhoto
        self.currentAvatarPic.kf.setImage(with: URL(string: imageUrlString))
    }
    
    func configView(_ user: RealmFriends) {
        userName.text = user.surName + " " + user.name
        let imageUrlString = user.friendPhoto
        self.currentAvatarPic.kf.setImage(with: URL(string: imageUrlString))
    }
    
    func config(userName: String, userPic: UIImage) {
        self.userName.text = userName
        self.currentAvatarPic.image = userPic
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        if (touch.view == currentAvatarPic) {
            UIView.animate(
                withDuration: 2,
                delay: 0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.4,
                options: .curveLinear,
                animations: {self.currentAvatarPic.frame.size = CGSize(width: 85, height: 85)},
                completion: nil)
            UIView.animate(
                withDuration: 2,
                delay: 0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.4,
                options: .curveLinear,
                animations: {self.currentAvatarShadow.frame.size = CGSize(width: 85, height: 85)},
                completion: nil)
            UIView.animate(
                withDuration: 2,
                delay: 0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.4,
                options: .curveLinear,
                animations: {self.currentAvatarView.bounds.size = CGSize(width: 85, height: 85)},
                completion: nil)
        }
    }
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

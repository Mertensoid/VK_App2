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

    @IBOutlet weak var currentAvatarShadow: UIView!
    
    @IBOutlet weak var currentAvatarPic: UIImageView!
    
    func configView(user: FriendData) {

        
        userName.text = user.surName + " " + user.name
        
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

        let imageUrlString = user.friendPhoto
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else { return }
            
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            
            // When from a background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                self.currentAvatarPic.image = image
            }
        }
        
        //currentAvatarPic.image = user.avatarPic
        currentAvatarPic.layer.cornerRadius = currentAvatarPic.frame.height / 2
        currentAvatarPic.clipsToBounds = true
        currentAvatarView.layer.cornerRadius = currentAvatarView.frame.height / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first as! UITouch
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
    
    //var currentAvatarView: AvatarView = AvatarView(frame: CGRect(x: 10.0, y: 10.0, width: 128.0, height: 128.0))
    
//    var currentAvatarPic: AvatarPicView = AvatarPicView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
//    var currentAvatarShadow: AvatarShadowView = AvatarShadowView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
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

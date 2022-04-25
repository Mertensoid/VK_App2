//
//  UsersTableViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit
import Kingfisher

class GroupsTableViewCell: UITableViewCell {
    @IBOutlet weak var groupPic: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    func configure(group: GroupData) {
        let imageUrlString = group.groupPic
        self.groupPic.kf.setImage(with: URL(string: imageUrlString))
        groupName.text = group.groupName
        groupPic.isUserInteractionEnabled = true
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        if (touch.view == groupPic) {
            UIView.animate(
                withDuration: 2,
                delay: 0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.4,
                options: .curveLinear,
                animations: {self.groupPic.bounds.size = CGSize(width: 70, height: 70)},
                completion: nil)
        }
    }
    
    func configure(group: RealmGroups) {
        let imageUrlString = group.groupPic
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                self.groupPic.image = image
            }
        }
        groupName.text = group.groupName
        groupPic.isUserInteractionEnabled = true
    }
    
    func config(groupName: String, groupPic: UIImage) {
        self.groupName.text = groupName
        self.groupPic.image = groupPic
    }
     
//
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        UIView.animate(
//            withDuration: 2,
//            delay: 0,
//            options: .curveLinear,
//            animations: {tappedImage.bounds.size = CGSize(width: 50, height: 50)},
//            completion: nil)
//    }
    
    
}

//
//  UserCollectionViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonPressed(_ sender: Any) {
//        switchButton()
    }
    
//    func switchButton() {
//        if self.likeButton.imageView?.image == UIImage(systemName: "heart.fill") {
//            self.likeButton.imageView?.image = UIImage(systemName: "heart")
//        } else {
//            self.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
//        }
//    }
    
    func configure(userPhoto: UserPhoto) {
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        
        userPic.image = userPhoto.photo
        if userPhoto.liked {
            likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            likeButton.imageView?.image = UIImage(systemName: "heart")
        }
    }
}

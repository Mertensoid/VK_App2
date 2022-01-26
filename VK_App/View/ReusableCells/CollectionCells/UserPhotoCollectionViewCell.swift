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
    @IBOutlet weak var likesCount: UILabel!
    
    //ДЗ №5
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        liked = !liked
        if liked {
            somePhotoModel?.likesCount += 1
            likesCount.text = String(somePhotoModel!.likesCount)
        } else {
            somePhotoModel?.likesCount -= 1
            likesCount.text = String(somePhotoModel!.likesCount)
        }
    }

    var somePhotoModel: UserPhoto? = nil
    var liked: Bool = false
    
    func configure(userPhoto: UserPhoto) {
        
        somePhotoModel = userPhoto
        if let value = somePhotoModel?.liked {
            liked = value
        } else { return }
        
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        //likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        
        userPic.image = userPhoto.photo
        if userPhoto.liked {
            likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            likeButton.imageView?.image = UIImage(systemName: "heart")
        }
        //userPhoto.likesCount = 100
        likesCount.text = String(userPhoto.likesCount)
        
    }
}

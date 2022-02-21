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
    
    var tempCount:String = ""
    
    //ДЗ №5
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        likedVar = !likedVar
        if likedVar {
            somePhotoModel?.likesCount += 1
            tempCount = String(somePhotoModel!.likesCount)
            UIView.transition(
                with: likesCount,
                duration: 0.5,
                options: .transitionFlipFromTop,
                animations: { self.likesCount.text = self.tempCount},
                completion: nil)
        } else {
            somePhotoModel?.likesCount -= 1
            tempCount = String(somePhotoModel!.likesCount)
            UIView.transition(
                with: likesCount,
                duration: 0.5,
                options: .transitionFlipFromBottom,
                animations: { self.likesCount.text = self.tempCount},
                completion: nil)
        }
    }

    var somePhotoModel: UserPhoto? = nil
    var likedVar: Bool = false
    
    func configure(userPhoto: UIImage, likesCounter: Int, liked: Bool) {
        
        //somePhotoModel = userPhoto
        if liked {
            likedVar = liked
        } else { return }
        
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        //likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        
        userPic.image = userPhoto
        if liked {
            likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            likeButton.imageView?.image = UIImage(systemName: "heart")
        }
        //userPhoto.likesCount = 100
        likesCount.text = String(likesCounter)
        
    }
}

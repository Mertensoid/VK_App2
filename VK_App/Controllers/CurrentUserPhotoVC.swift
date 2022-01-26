//
//  CurrentUserPhotoVC.swift
//  VK_App
//
//  Created by admin on 26.01.2022.
//

import UIKit

class CurrentUserPhotoVC: UIViewController {
    @IBOutlet weak var currentImageView: UIImageView!
    
    let leftImageView = UIImageView()
    let rightImageView = UIImageView()
    
    var photos: [UIImage] = []
    var currentPhotoIndex: Int = 0
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    private var isAnimated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentImageView.image = photos[currentPhotoIndex]
        if currentPhotoIndex == 0 && currentPhotoIndex != photos.count-1 {
            leftImageView.image = photos[photos.count-1]
            rightImageView.image = photos[currentPhotoIndex + 1]
        } else if currentPhotoIndex != 0 && currentPhotoIndex == photos.count-1 {
            leftImageView.image = photos[currentPhotoIndex - 1]
            rightImageView.image = photos[0]
        } else if photos.count == 0 {
            leftImageView.image = photos[currentPhotoIndex]
            rightImageView.image = photos[currentPhotoIndex]
        } else {
            leftImageView.image = photos[currentPhotoIndex - 1]
            rightImageView.image = photos[currentPhotoIndex + 1]
        }
        
        leftImageView.frame.size.height = currentImageView.frame.height
        leftImageView.frame.size.width = currentImageView.frame.width
        leftImageView.center.x = currentImageView.center.x - currentImageView.frame.width
        leftImageView.center.y = currentImageView.center.y
        rightImageView.frame.size.height = currentImageView.frame.height
        rightImageView.frame.size.width = currentImageView.frame.width
        rightImageView.center.x = currentImageView.center.x + currentImageView.frame.width
        rightImageView.center.y = currentImageView.center.y
        
        self.view.addSubview(leftImageView)
        self.view.addSubview(rightImageView)
        
        
        currentImageView.isUserInteractionEnabled = true
        leftImageView.isUserInteractionEnabled = true
        rightImageView.isUserInteractionEnabled = true
        
        currentImageView.addGestureRecognizer(UISwipeGestureRecognizer(
            target: self,
            action: #selector(didSwipe(_:))))
    }
    
    @objc
    private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            UIView.animate(
                withDuration: 1,
                delay: 0,
                animations: {self.rightImageView.center.x -= self.currentImageView.frame.width},
                completion: nil)
//            propertyAnimator = UIViewPropertyAnimator(
//                duration: 1,
//                curve: .linear,
//                animations: {
//                    self.rightImageView.center.x -= self.currentImageView.frame.width
//                })
//            propertyAnimator.pauseAnimation()
        case .right:
            UIView.animate(
                withDuration: 1,
                delay: 0,
                animations: {self.leftImageView.center.x += self.currentImageView.frame.width},
                completion: nil)
//            let translation = gesture.translation(in: self.rightImageView)
//            propertyAnimator.fractionComplete = -translation.y
        default:
            return
        }
    }
}

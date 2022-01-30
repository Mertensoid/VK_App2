//
//  CurrentUserPhotoVC.swift
//  VK_App
//
//  Created by admin on 26.01.2022.
//

import UIKit

class CurrentUserPhotoVC: UIViewController {
    @IBOutlet weak var currentImageView: UIImageView!
    //@IBOutlet weak var leftImageView: UIImageView!
    //@IBOutlet weak var rightImageView: UIImageView!
    
    var leftImageView = UIImageView()
    var rightImageView = UIImageView()
    
    var photos: [UIImage] = []
    var currentPhotoIndex: Int = 0
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    private var isAnimated = false
    
    private func setNewPhotos() {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewPhotos()
        
        leftImageView.frame.size.height = currentImageView.frame.height
        leftImageView.frame.size.width = view.bounds.width
        leftImageView.center.x = currentImageView.center.x - currentImageView.bounds.width
        leftImageView.center.y = view.center.y
        rightImageView.frame.size.height = currentImageView.frame.height
        rightImageView.frame.size.width = view.bounds.width
        rightImageView.center.x = currentImageView.center.x + currentImageView.bounds.width
        rightImageView.center.y = view.center.y

        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit

        currentImageView.addSubview(leftImageView)
        currentImageView.addSubview(rightImageView)
        
        
        currentImageView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc
    private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            print("right")
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                animations: {self.leftImageView.center.x = self.currentImageView.center.x},
                completion: {_ in
                    if self.currentPhotoIndex == 0 {
                        self.currentPhotoIndex = self.photos.count-1
                        print(self.currentPhotoIndex)
                    } else {
                        self.currentPhotoIndex -= 1
                        print(self.currentPhotoIndex)
                    }
                    self.setNewPhotos()
                    self.leftImageView.center.x = self.currentImageView.center.x - self.currentImageView.bounds.width
                })
        case .left:
            print("left")
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                animations: {self.rightImageView.center.x = self.currentImageView.center.x},
                completion: {_ in
                    switch self.currentPhotoIndex {
                    case self.photos.count-1:
                        self.currentPhotoIndex = 0
                        print(self.currentPhotoIndex)
                    default:
                        self.currentPhotoIndex += 1
                        print(self.currentPhotoIndex)
                    }
                    self.setNewPhotos()
                    self.rightImageView.center.x = self.currentImageView.center.x + self.currentImageView.bounds.width
            })
        default:
            return
        }
    }
}

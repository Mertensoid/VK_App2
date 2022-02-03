//
//  CurrentUserPhotoVC.swift
//  VK_App
//
//  Created by admin on 26.01.2022.
//

import UIKit

class CurrentUserPhotoVC: UIViewController {
    @IBOutlet weak var currentImageView: UIImageView!
    
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

        leftImageView.isHidden = true
        rightImageView.isHidden = true
        view.addSubview(leftImageView)
        view.addSubview(rightImageView)
        
        
        currentImageView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        leftImageView.isHidden = false
        rightImageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        leftImageView.isHidden = true
        rightImageView.isHidden = true
    }
    
    @objc
    private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:

            self.rightImageView.center.x = self.currentImageView.center.x
            
            if self.currentPhotoIndex == 0 {
                self.currentPhotoIndex = self.photos.count-1
            } else {
                self.currentPhotoIndex -= 1
            }
            self.setNewPhotos()
            
            self.currentImageView.bounds.size.height *= 0.8
            self.currentImageView.bounds.size.width *= 0.8
            
            UIView.animateKeyframes(
                withDuration: 0.7,
                delay: 0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.height /= 0.8
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.width /= 0.8
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 1,
                        animations: {
                            self.rightImageView.center.x = self.currentImageView.center.x + self.currentImageView.bounds.width
                        }
                    )
                },
                completion: nil)
        
        case .left:
            
            UIView.animateKeyframes(
                withDuration: 0.7,
                delay: 0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.height *= 0.8
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.width *= 0.8
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 1,
                        animations: {
                            self.rightImageView.center.x = self.currentImageView.center.x
                        }
                    )
                },
                completion: {_ in
                    switch self.currentPhotoIndex {
                    case self.photos.count-1:
                        self.currentPhotoIndex = 0
                    default:
                        self.currentPhotoIndex += 1
                    }
                    self.setNewPhotos()
                    self.rightImageView.center.x = self.currentImageView.center.x + self.currentImageView.bounds.width
                })
            
        default:
            return
        }
    }
}

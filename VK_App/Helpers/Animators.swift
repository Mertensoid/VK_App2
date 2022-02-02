//
//  Animators.swift
//  VK_App
//
//  Created by admin on 02.02.2022.
//

import UIKit

class SomeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        //let animationGroup = CAAnimationGroup()
        destination.view.frame = transitionContext.containerView.frame
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.position = CGPoint(x: source.view.bounds.width, y: 0.0)
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.position = CGPoint(x: source.view.bounds.width, y: 0)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        
        
//        UIView.animateKeyframes(
//            withDuration: animationTime,
//            delay: 0,
//            options: [],
//            animations: {
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0,
//                    relativeDuration: 1,
//                    animations: {
//                        CGAffineTransform(rotationAngle: -90.0)
//                    }
//                )
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0,
//                    relativeDuration: 1,
//                    animations: {
//                        CGAffineTransform(rotationAngle: -90.0)
//                    }
//                )
//            })
        
        //
        
        
//        CGAffineTransform(
//            translationX:  source.view.bounds.width,
//            y: source.view.bounds.height)
//
        UIView.animate(
            withDuration: animationTime,
            animations: {
                source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
                destination.view.transform = .identity
            },
            completion: { isComplete in
                transitionContext.completeTransition(isComplete)
            })
    }
    
    private let animationTime = 1.0
    
    
}

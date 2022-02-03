//
//  NavigationViewRotationForwardAnimator.swift
//  VK_App
//
//  Created by admin on 03.02.2022.
//

import UIKit

class NavigationViewRotationForwardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        guard
            let source = transitionContext.viewController(forKey: .from)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.position = CGPoint(x: source.view.bounds.width, y: 0.0)
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.position = CGPoint(x: source.view.bounds.width, y: 0)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        UIView.animate(
            withDuration: animationTime,
            animations: {
                source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
                destination.view.transform = .identity
            },
            completion: { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            })
    }
}

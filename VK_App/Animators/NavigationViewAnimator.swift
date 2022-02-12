//
//  NavigationViewAnimator.swift
//  VK_App
//
//  Created by admin on 03.02.2022.
//

import UIKit

class NavigationViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(
            translationX: source.view.frame.width,
            y: 0.0)
        
        UIView.animateKeyframes(
            withDuration: animationTime,
            delay: 0.0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.75,
                    animations: {
                        let translation = CGAffineTransform(
                            translationX: -200.0,
                            y: 0.0)
                        let scale = CGAffineTransform(
                            scaleX: 0.8,
                            y: 0.8)
                        source.view.transform = translation.concatenating(scale)
                    })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.4,
                    animations: {
                        let translation = CGAffineTransform(
                            translationX: source.view.frame.width / 2,
                            y: 0.0)
                        let scale = CGAffineTransform(
                            scaleX: 1.2,
                            y: 1.2)
                        destination.view.transform = translation.concatenating(scale)
                    })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4,
                    animations: {
                        destination.view.transform = .identity
                    })
            },
            completion: { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            })
    }
    
    
}

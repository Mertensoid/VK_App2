//
//  CustomNavigationController.swift
//  VK_App
//
//  Created by admin on 03.02.2022.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return NavigationViewRotationForwardAnimator()
        } else if operation == .pop {
            if self.interactiveTransition.viewController != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return NavigationViewRotationBackwardAnimator()
        } else {
            return nil
        }
    }
    
    
    let interactiveTransition = CustomInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }

}

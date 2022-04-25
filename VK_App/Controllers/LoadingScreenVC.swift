//
//  LoadingScreenVC.swift
//  VK_App
//
//  Created by admin on 24.01.2022.
//

import UIKit

class LoadingScreenVC: UIViewController {

    @IBOutlet weak var loadingIndicator1: UIView!
    @IBOutlet weak var loadingIndicator2: UIView!
    @IBOutlet weak var loadingIndicator3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator1.layer.cornerRadius = 12
        loadingIndicator1.clipsToBounds = true
        loadingIndicator1.alpha = 0.3
        
        loadingIndicator2.layer.cornerRadius = 12
        loadingIndicator2.clipsToBounds = true
        loadingIndicator2.alpha = 0.3
        
        loadingIndicator3.layer.cornerRadius = 12
        loadingIndicator3.clipsToBounds = true
        loadingIndicator3.alpha = 0.3
        
        animate1()
        animate2()
        animate3()
    }
    
    func animate1() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .autoreverse,
            animations: {self.loadingIndicator1.alpha = 1},
            completion: {_ in self.loadingIndicator1.alpha = 0.3})
    }
    
    func animate2() {
        UIView.animate(
            withDuration: 1,
            delay: 1,
            options: .autoreverse,
            animations: {self.loadingIndicator2.alpha = 1},
            completion: {_ in self.loadingIndicator2.alpha = 0.3})
    }
    
    func animate3() {
        UIView.animate(
            withDuration: 1,
            delay: 2,
            options: .autoreverse,
            animations: {self.loadingIndicator3.alpha = 1},
            completion: {_ in
                self.loadingIndicator3.alpha = 0.3
                self.performSegue(withIdentifier: "goToLoginScreen", sender: nil)
            })
    }
}

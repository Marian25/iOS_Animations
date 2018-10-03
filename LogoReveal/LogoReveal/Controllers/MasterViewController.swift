//
//  ViewController.swift
//  LogoReveal
//
//  Created by Marian Stanciulica on 02/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

// MARK: - Delay Function

func delay(seconds: Double, completion: @escaping () -> ()) {
    let milliseconds = Int(1000 * seconds)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
        completion()
    }
}

class MasterViewController: UIViewController {

    let logo = RWLogoLayer.logoLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Start"
        navigationController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add the Tap Gesture Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        // Add the Logo to the view
        logo.position = CGPoint(x: view.layer.bounds.size.width / 2,
                                y: view.layer.bounds.size.width / 2 - 30)
        logo.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(logo)
    }
    
    // MARK: - Gesture Recognizer Handler
    
    @objc func didTap() {
        performSegue(withIdentifier: "details", sender: nil)
    }


}

extension MasterViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

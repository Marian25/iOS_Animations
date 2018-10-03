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
    let transition = RevealAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Start"
        navigationController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add the Tap Gesture Recognizer
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        view.addGestureRecognizer(pan)
        
        // Add the Logo to the view
        logo.position = CGPoint(x: view.layer.bounds.size.width / 2,
                                y: view.layer.bounds.size.height / 2 - 30)
        logo.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(logo)
    }
    
    // MARK: - Gesture Recognizer Handler
    
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            transition.interactive = true
            performSegue(withIdentifier: "details", sender: nil)
        default:
            transition.handlePan(recognizer: recognizer)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "details":
            guard let destination = segue.destination as? DetailTableViewController else { return }
            destination.transition = transition
        default:
            break
        }
    }

}

extension MasterViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.operation = operation
        return transition
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if !transition.interactive{
            return nil
        }
        
        return transition
    }
    
}

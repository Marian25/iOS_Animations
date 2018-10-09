//
//  ContainerViewController.swift
//  PhoneBookAnimations
//
//  Created by Marian Stanciulica on 09/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    let menuWidth: CGFloat = 80.0
    let animationTime: TimeInterval = 0.5
    
    let menuViewController: UIViewController
    let centerViewController: UINavigationController
    
    var isOpening = false
    
    init(sideMenu: UIViewController, center: UINavigationController) {
        menuViewController = sideMenu
        centerViewController = center
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setNeedsStatusBarAppearanceUpdate()
        
        addChild(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.didMove(toParent: self)
        
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
        
        menuViewController.view.layer.anchorPoint.x = 1.0
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(panGesture)
        
        setToPercent(0.0)
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        
        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        case .began:
            let isOpen = floor(centerViewController.view.frame.origin.x / menuWidth)
            isOpening = isOpen == 1.0 ? false : true
            menuViewController.view.layer.shouldRasterize = true
            menuViewController.view.layer.rasterizationScale = UIScreen.main.scale
        case .changed:
            self.setToPercent(isOpening ? progress : (1.0 - progress))
        case .ended, .cancelled, .failed:
            var targetProgress: CGFloat
            
            if isOpening {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animate(withDuration: animationTime, animations: {
                self.setToPercent(targetProgress)
            }) { _ in
                self.menuViewController.view.layer.shouldRasterize = false
            }
        default:
            break
        }
    }
    
    func toggleSideMenu() {
        let isOpen = floor(centerViewController.view.frame.origin.x / menuWidth)
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0 : 1.0
        
        UIView.animate(withDuration: animationTime, animations: {
            self.setToPercent(targetProgress)
        }) { _ in
            self.menuViewController.view.layer.shouldRasterize = false
        }
    }

    func setToPercent(_ percent: CGFloat) {
        centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
        menuViewController.view.layer.transform = menuTransform(percent: percent)
        menuViewController.view.alpha = CGFloat(max(0.2, percent))
        
        let centerVC = centerViewController.children.first as? CenterViewController
        let angle = percent * .pi
        let rotationTransform = CATransform3DRotate(CATransform3DIdentity, angle, 1.0, 1.0, 0.0)
        centerVC?.menuButton?.imageView.layer.transform = rotationTransform
        
    }
    
    func menuTransform(percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000
        
        let remainingPercent = 1.0 - percent
        let angle = remainingPercent * .pi * -0.5
        
        let rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0)
        let translationTransform = CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
        return CATransform3DConcat(rotationTransform, translationTransform)
    }
    
}

//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by Marian Stanciulica on 03/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import Foundation
import UIKit

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    let animationDuration = 2.0
    var operation: UINavigationController.Operation = .push
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        if operation == .push {
            let fromVC = transitionContext.viewController(forKey: .from) as! MasterViewController
            let toVC = transitionContext.viewController(forKey: .to) as! DetailTableViewController
            
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
            animation.toValue = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0)))
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
            
            let maskLayer: CAShapeLayer = RWLogoLayer.logoLayer()
            maskLayer.position = fromVC.logo.position
            toVC.view.layer.mask = maskLayer
            maskLayer.add(animation, forKey: nil)
            
            fromVC.logo.add(animation, forKey: nil)
            
            let opacity = CABasicAnimation(keyPath: "opacity")
            opacity.duration = animationDuration
            opacity.fromValue = 0.0
            opacity.toValue = 1.0
            toVC.view.layer.add(opacity, forKey: nil)
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            guard let toView = transitionContext.view(forKey: .to) else { return }
            
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)

            UIView.animate(withDuration: animationDuration, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled)
            
            let fromVC = context.viewController(forKey: .from) as! MasterViewController
            fromVC.logo.removeAllAnimations()
            
            let toVC = context.viewController(forKey: .to) as! DetailTableViewController
            toVC.view.layer.mask = nil
            
        }
        storedContext = nil
    }
    
}

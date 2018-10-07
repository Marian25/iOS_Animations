//
//  AnimatorFactory.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 07/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class AnimatorFactory {
    
    static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
        let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
        scale.addAnimations {
            view.alpha = 1.0
        }
        scale.addAnimations ({
            view.transform = CGAffineTransform.identity
        }, delayFactor: 0.33)
        scale.addCompletion { _ in
            print("ready")
        }
        return scale
    }
    
    @discardableResult
    static func jiggle(view: UIView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.33, delay: 0, options: [], animations: {
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                    view.transform = CGAffineTransform(rotationAngle: -.pi / 8)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
                    view.transform = CGAffineTransform(rotationAngle: .pi / 8)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1, animations: {
                    view.transform = CGAffineTransform.identity
                })
                
            }, completion: nil)
            
        }, completion: { _ in
            view.transform = .identity
        })
    }
    
    static func fade(view: UIView, blurred: Bool) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            view.alpha = blurred ? 1 : 0
        }, completion: nil)
    }
    
}

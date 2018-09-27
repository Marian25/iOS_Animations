//
//  AvatarView.swift
//  ShapeMorphing
//
//  Created by Marian Stanciulica on 27/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    let photoLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    let label = UILabel()
    
    var image: UIImage? {
        didSet {
            photoLayer.contents = image?.cgImage
        }
    }
    
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    let lineWidth: CGFloat = 6.0
    let animationDuration = 1.0
    
    var shouldTransitiontoFinishedState = false
    var isSquare = false
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = .clear
        
        // Add the Initial Image of the Avatar View
        guard let blankImage = UIImage(named: "empty") else { return }
        photoLayer.contents = blankImage.cgImage
        photoLayer.frame = CGRect(
            x: (bounds.size.width - blankImage.size.width + lineWidth) / 2.0,
            y: (bounds.size.height - blankImage.size.height - lineWidth) / 2.0,
            width: blankImage.size.width,
            height: blankImage.size.height)
        
        layer.addSublayer(photoLayer)
        
        // Draw the Circle
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleLayer)
        
        // Mask Layer
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: 10.0)
        photoLayer.mask = maskLayer
        
        // Add Label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10, width: bounds.size.width, height: 24)
        label.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
    }
    
    func bounceOff(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.center = point
        }) { _ in
            if self.shouldTransitiontoFinishedState {
                self.animateToSquare()
            }
        }
        
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
            self.center = originalCenter
        }) { _ in
            delay(seconds: 0.1) {
                if !self.isSquare {
                    self.bounceOff(point: point, morphSize: morphSize)
                }
            }
        }
        
        let morphedFrame = (originalCenter.x > point.x) ?
            CGRect(x: 0.0,
                   y: bounds.height - morphSize.height,
                   width: morphSize.width,
                   height: morphSize.height) :
            CGRect(x: bounds.width - morphSize.width,
                   y: bounds.height - morphSize.height,
                   width: morphSize.width,
                   height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        circleLayer.add(morphAnimation, forKey: nil)
        maskLayer.add(morphAnimation, forKey: nil)
    }
    
    func animateToSquare() {
        isSquare = true
        let squarePath = UIBezierPath(rect: bounds)
        let layerAnimation = CABasicAnimation(keyPath: "path")
        layerAnimation.duration = 0.25
        layerAnimation.fromValue = circleLayer.path
        layerAnimation.toValue = squarePath
        circleLayer.add(layerAnimation, forKey: nil)
        circleLayer.path = squarePath.cgPath
        maskLayer.add(layerAnimation, forKey: nil)
        maskLayer.path = squarePath.cgPath
    }
    
}

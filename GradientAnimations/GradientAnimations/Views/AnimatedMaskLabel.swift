//
//  AnimatedMaskLabel.swift
//  GradientAnimations
//
//  Created by Marian Stanciulica on 27/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class AnimatedMaskLabel: UIView {
    
    var gradientLayer = CAGradientLayer()
    var text = "Slide to reveal"
    
    let textAttributes: [NSAttributedString.Key: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
            NSAttributedString.Key.paragraphStyle: style
        ]
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Set the Background Color
        backgroundColor = .black
        clipsToBounds = true
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            UIColor.white.cgColor,
            UIColor.green.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.cyan.cgColor,
            UIColor.red.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.colors = colors
        
        let locations: [NSNumber] = [0.25, 0.50, 0.75]
        gradientLayer.locations = locations
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = CGRect(x: -bounds.size.width,
                                     y: bounds.origin.y,
                                     width: 3 * bounds.size.width,
                                     height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)

        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 0.75, 0.8, 0.85, 0.9, 0.95, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        
        let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
            text.draw(in: bounds, withAttributes: textAttributes)
        }
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
        maskLayer.contents = image.cgImage
        gradientLayer.mask = maskLayer
    }
    
}

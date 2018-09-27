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
    
}

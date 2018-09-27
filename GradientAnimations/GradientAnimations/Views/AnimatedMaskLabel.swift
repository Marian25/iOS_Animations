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
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Set the Background Color
        backgroundColor = .black
        clipsToBounds = true
    }
    
}

//
//  IconEffectView.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 07/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class IconEffectView: UIVisualEffectView {
    
    convenience init(blur: UIBlurEffect.Style) {
        self.init(effect: UIBlurEffect(style: blur))
        
        clipsToBounds = true
        layer.cornerRadius = 16.0
        
        let label = UILabel()
        label.text = "Customize Actions..."
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.sizeToFit()
        label.center = CGPoint(x: 90, y: 30)
        contentView.addSubview(label)
    }
    
}

//
//  MenuItem.swift
//  PhoneBookAnimations
//
//  Created by Marian Stanciulica on 09/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class MenuButton: UIView {
    
    var imageView: UIImageView!
    var tapHandler: ( () -> () )?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        addSubview(imageView)
    }
    
    @objc func didTap() {
        tapHandler?()
    }
    
}

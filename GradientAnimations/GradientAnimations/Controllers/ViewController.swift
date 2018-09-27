//
//  ViewController.swift
//  GradientAnimations
//
//  Created by Marian Stanciulica on 27/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var timeLabel: UIView!
    @IBOutlet weak var slideView: AnimatedMaskLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSlide))
        swipe.direction = .right
        slideView.addGestureRecognizer(swipe)
    }

    @objc func didSlide() {
        print("Did Slide!")
    }

}


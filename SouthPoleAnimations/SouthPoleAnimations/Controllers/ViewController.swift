//
//  ViewController.swift
//  SouthPoleAnimations
//
//  Created by Marian Stanciulica on 09/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var penguin: UIImageView!
    @IBOutlet weak var slideButton: UIButton!

    var isLookingRight = true
    var penguinY: CGFloat!
    
    var walkSize: CGSize!
    var slideSize: CGSize!
    
    let animationDuration = 1.0
    
    var walkFrames = [
        UIImage(named: "walk01.png")!,
        UIImage(named: "walk02.png")!,
        UIImage(named: "walk03.png")!,
        UIImage(named: "walk04.png")!
    ]
    
    var slideFrames = [
        UIImage(named: "slide01.png")!,
        UIImage(named: "slide02.png")!,
        UIImage(named: "slide01.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walkSize = walkFrames[0].size
        slideSize = slideFrames[0].size
        penguinY = penguin.frame.origin.y
    }
    
    func loadWalkAnimation() {
        
    }
    
    func loadSlideAnimation() {
        
    }

    @IBAction func actionLeft(_ sender: Any) {
        
    }
    
    @IBAction func actionRight(_ sender: Any) {
    
    }
    
    @IBAction func actionSlide(_ sender: Any) {
    
    }
}


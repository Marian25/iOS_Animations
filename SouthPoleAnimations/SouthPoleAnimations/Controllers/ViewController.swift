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

    var isLookingRight: Bool = true {
        didSet {
            let xScale: CGFloat = isLookingRight ? 1 : -1
            penguin.transform = CGAffineTransform(scaleX: xScale, y: 1)
            slideButton.transform = penguin.transform
        }
    }
    
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

        loadWalkAnimation()
    }
    
    func loadWalkAnimation() {
        penguin.animationImages = walkFrames
        penguin.animationDuration = animationDuration / 3
        penguin.animationRepeatCount = 3
    }
    
    func loadSlideAnimation() {
        penguin.animationImages = slideFrames
        penguin.animationDuration = animationDuration
        penguin.animationRepeatCount = 1
    }

    @IBAction func actionLeft(_ sender: Any) {
        isLookingRight = false
        penguin.startAnimating()
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.penguin.center.x -= self.walkSize.width
        }, completion: nil)
    }
    
    @IBAction func actionRight(_ sender: Any) {
        isLookingRight = true
        penguin.startAnimating()
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.penguin.center.x += self.walkSize.width
        }, completion: nil)
    }
    
    @IBAction func actionSlide(_ sender: Any) {
        loadSlideAnimation()
        
        penguin.frame = CGRect(x: penguin.frame.origin.x,
                               y: penguinY + walkSize.height - slideSize.height,
                               width: slideSize.width,
                               height: slideSize.height)
        penguin.startAnimating()
        
        UIView.animate(withDuration: animationDuration - 0.02, delay: 0.0, options: .curveEaseOut, animations: {
            self.penguin.center.x += self.isLookingRight ? self.slideSize.width : -self.slideSize.width
        }) { _ in
            self.penguin.frame = CGRect(x: self.penguin.frame.origin.x,
                                        y: self.penguinY,
                                        width: self.walkSize.width,
                                        height: self.walkSize.height)
            self.loadWalkAnimation()
        }
    }
}


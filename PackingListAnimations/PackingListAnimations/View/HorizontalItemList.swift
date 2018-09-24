//
//  HorizontalItemList.swift
//  PackingListAnimations
//
//  Created by Marian Stanciulica on 24/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class HorizontalItemList: UIScrollView {
    
    //    MARK: Properties - State
    
    var didSelectItem: ((Int) -> ())?
    
    let buttonWidth: CGFloat = 60.0
    let padding: CGFloat = 10.0
    
    //    MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: inView.bounds.width, y: 120.0, width: inView.frame.width, height: 80.0)
        self.init(frame: rect)
        
        self.alpha = 0.0
        
        for i in 0..<10 {
            let image = UIImage(named: "summericons_100px_0\(i).png")
            let imageView  = UIImageView(image: image)
            imageView.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonWidth/2)
            imageView.tag = i
            imageView.isUserInteractionEnabled = true
            addSubview(imageView)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
            imageView.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(width: padding * buttonWidth, height:  buttonWidth + 2*padding)
    }
    
    //    MARK: Actions
    
    @objc func didTapImage(tap: UITapGestureRecognizer) {
        didSelectItem?(tap.view!.tag)
    }
    
    //    MARK: View Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview == nil {
            return
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
            self.center.x -= self.frame.size.width
        }, completion: nil)
    }
    
    
}

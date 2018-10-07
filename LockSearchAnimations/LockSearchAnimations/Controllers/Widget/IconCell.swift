//
//  IconCell.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 04/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!

    var animator: UIViewPropertyAnimator?
    
    func iconJiggle() {
        if let animator = animator, animator.isRunning {
            return
        }
        self.animator = AnimatorFactory.jiggle(view: icon)
    }
}

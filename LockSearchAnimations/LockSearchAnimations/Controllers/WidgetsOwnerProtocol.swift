//
//  WidgetsOwnerProtocol.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 04/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

protocol WidgetsOwnerProtocol {
    var blurView: UIVisualEffectView {get}
    
    func startPreview(for: UIView)
    func updatePreview(percent: CGFloat)
    func finishPreview()
    func cancelPreview()
}

extension WidgetsOwnerProtocol {
    func startPreview(for forView: UIView) { }
    func updatePreview(percent: CGFloat) { }
    func finishPreview() { }
    func cancelPreview() { }
}

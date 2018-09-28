//
//  RefreshView.swift
//  RefreshAnimation
//
//  Created by Marian Stanciulica on 28/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

// MARK: - Refresh View Delegate Protocol

protocol RefreshViewDelegate {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

// MARK: - Refresh View

class RefreshView: UIView, UIScrollViewDelegate {
    
    var delegate: RefreshViewDelegate?
    var scrollView: UIScrollView?
    var progress: CGFloat = 0.0
    var isRefreshing = false
    
    let ovalShapeLayer = CAShapeLayer()
    let airplaneLayer = CALayer()
    let textLayer = CATextLayer()
    
    init(frame: CGRect, scrollView: UIScrollView) {
        super.init(frame: frame)
        
        self.scrollView = scrollView
        
        // Add the Background
        addSubview(UIImageView(image: UIImage(named: "refresh-view-bg")))
        
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4.0
        ovalShapeLayer.lineDashPattern = [2, 3]
        
        let refreshRadius = frame.size.height / 2 * 0.8
        
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width / 2 - refreshRadius, y: frame.size.height / 2 - refreshRadius, width: 2 * refreshRadius, height: 2 * refreshRadius)).cgPath
        layer.addSublayer(ovalShapeLayer)
        
        let airplaneImage = UIImage(named: "airplane")!
        airplaneLayer.contents = airplaneImage.cgImage
        airplaneLayer.bounds = CGRect(x: 0.0, y: 0.0, width: airplaneImage.size.width, height: airplaneImage.size.height)
        airplaneLayer.position = CGPoint(x: frame.size.width / 2 + refreshRadius, y: frame.size.height / 2)
        
        layer.addSublayer(airplaneLayer)
        
        airplaneLayer.opacity = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Scroll View Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = CGFloat(max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress()
        }
    }
    
    func redrawFromProgress() {
        ovalShapeLayer.strokeEnd = progress
        airplaneLayer.opacity = Float(progress)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(refreshView: self)
            beginRefreshing()
        }
    }
    
    // MARK: - Animate the Refresh View
    
    func beginRefreshing() {
        isRefreshing = true
        
        UIView.animate(withDuration: 0.3) {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView?.contentInset = newInsets
        }
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = 5.0
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        flightAnimation.calculationMode = CAAnimationCalculationMode.paced
        
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2.0 * .pi
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = 5.0
        flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
        airplaneLayer.add(flightAnimationGroup, forKey: nil)
    }
    
    func endRefreshing() {
        isRefreshing = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView?.contentInset = newInsets
        }) { _ in
            //
        }
    }
    
    
}

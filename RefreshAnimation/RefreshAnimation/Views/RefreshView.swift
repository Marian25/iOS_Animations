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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Scroll View Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = CGFloat(max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
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

//
//  ViewController.swift
//  CookAnimations
//
//  Created by Marian Stanciulica on 02/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

let herbs = HerbModel.all()

class ViewController: UIViewController {

    @IBOutlet weak var listView: UIScrollView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var selectedImage: UIImageView?
    let transition = PopAnimator()
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.dismissCompletion = {
            self.selectedImage?.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if listView.subviews.count < herbs.count {
            listView.viewWithTag(0)?.tag = 1000
            setupList()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - View Setup
    
    func setupList() {
        
        for i in herbs.indices {
            // Create Image View
            let imageView = UIImageView(image: UIImage(named: herbs[i].image))
            imageView.tag = i
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)
            
            // Attach Tap Detector
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
        }
        
        listView.backgroundColor = .clear
        positionListItems()
    }
    
    func positionListItems() {
        
        let listHeight = listView.frame.height
        let itemHeight: CGFloat = listHeight * 1.33
        let aspectRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        let itemWidth: CGFloat = itemHeight / aspectRatio
        let horizontalPadding: CGFloat = 10.0
        
        for i in herbs.indices {
            let imageView = listView.viewWithTag(i) as! UIImageView
            imageView.frame = CGRect(x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, y: 0.0, width: itemWidth, height: itemHeight)
        }
        
        listView.contentSize = CGSize(width: CGFloat(herbs.count) * (itemWidth + horizontalPadding) + horizontalPadding, height: 0)
    }
    
    @objc func didTapImageView(_ tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = selectedImage!.tag
        let selectedHerb = herbs[index]
        
        let herbDetails = storyboard!.instantiateViewController(withIdentifier: "HerbDetailsViewController") as! HerbDetailsViewController
        herbDetails.herb = selectedHerb
        herbDetails.transitioningDelegate = self
        present(herbDetails, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            self.backgroundImage.alpha = (size.width > size.height) ? 0.25 : 0.55
            self.positionListItems()
        }, completion: nil)
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage!.superview!.convert(selectedImage!.frame, to: nil)
        transition.presenting = true
        selectedImage?.isHidden = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

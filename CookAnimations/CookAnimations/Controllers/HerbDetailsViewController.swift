//
//  HerbDetailsViewController.swift
//  CookAnimations
//
//  Created by Marian Stanciulica on 02/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class HerbDetailsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var licenseButton: UIButton!
    @IBOutlet weak var authorButton: UIButton!
    
    var herb: HerbModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImage.image = UIImage(named: herb.image)
        titleLabel.text = herb.name
        descriptionTextView.text = herb.description
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose)))
    }
    
    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions

    @IBAction func actionLicense(_ sender: Any) {
        UIApplication.shared.open(URL(string: herb!.license)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func actionAuthor(_ sender: Any) {
        UIApplication.shared.open(URL(string: herb!.credit)!, options: [:], completionHandler: nil)
    }
}

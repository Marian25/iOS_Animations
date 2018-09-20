//
//  ViewController.swift
//  LoginAnimations
//
//  Created by Marian Stanciulica on 20/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cloud1ImageView: UIImageView!
    @IBOutlet weak var cloud4ImageVIew: UIImageView!
    @IBOutlet weak var cloud3ImageView: UIImageView!
    @IBOutlet weak var cloud2ImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headingLabel.center.x -= view.bounds.width
        usernameTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.headingLabel.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.usernameTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
            self.passwordTextField.center.x += self.view.bounds.width
        }, completion: nil)
    }


}


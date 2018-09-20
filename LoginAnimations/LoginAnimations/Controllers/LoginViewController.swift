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
    @IBOutlet weak var cloud2ImageView: UIImageView!
    @IBOutlet weak var cloud3ImageView: UIImageView!
    @IBOutlet weak var cloud4ImageView: UIImageView!
    
    // MARK: -
    
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    private let statusImageView = UIImageView(image: UIImage(named: "banner"))
    private let statusLabel = UILabel()
    private let statusMessages = ["Connecting...", "Authorizing...", "Sending credentials...", "Failed"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        statusImageView.isHidden = true
        statusImageView.center = loginButton.center
        view.addSubview(statusImageView)
        
        statusLabel.frame = CGRect(x: 0, y: 0, width: statusImageView.frame.size.width, height: statusImageView.frame.size.height)
        statusLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        statusLabel.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        statusLabel.textAlignment = .center
        statusImageView.addSubview(statusLabel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headingLabel.center.x -= view.bounds.width
        usernameTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        
        cloud1ImageView.alpha = 0.0
        cloud2ImageView.alpha = 0.0
        cloud3ImageView.alpha = 0.0
        cloud4ImageView.alpha = 0.0
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.headingLabel.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            self.usernameTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            self.passwordTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.cloud1ImageView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.cloud2ImageView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.cloud3ImageView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
            self.cloud4ImageView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
        }, completion: nil)
        
    }

    // MARK: - Actions
    
    @IBAction func login(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1.0
        }, completion: nil)
        
    }
    
    // MARK: -
    
    func showMessage(index: Int) {
        statusLabel.text = statusMessages[index]
        
        UIView.transition(with: statusImageView, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.statusImageView.isHidden = false
        }) { _ in
            // transition completion
        }
    }

}


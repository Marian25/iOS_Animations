//
//  ViewController.swift
//  LoginAnimations
//
//  Created by Marian Stanciulica on 20/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

// MARK: - Delay Function

func delay(seconds: Double, completion: @escaping () -> ()) {
    let milliseconds = Int(1000 * seconds)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
        completion()
    }
}

func tintBackgroundColor(layer: CALayer, toColor: UIColor) {
    let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
    colorAnimation.fromValue = layer.backgroundColor
    colorAnimation.toValue = toColor.cgColor
    colorAnimation.duration = 1.0
    layer.add(colorAnimation, forKey: nil)
    layer.backgroundColor = toColor.cgColor
}

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
    
    private let info = UILabel()
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    private let statusImageView = UIImageView(image: UIImage(named: "banner"))
    private let statusLabel = UILabel()
    private let statusMessages = ["Connecting...", "Authorizing...", "Sending credentials...", "Failed"]
    
    private var statusImageViewPosition = CGPoint.zero
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
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
        
        // Save Initial Properties
        statusImageViewPosition = statusImageView.center
        
        info.frame = CGRect(x: 0.0, y: loginButton.center.y + 60.0, width: view.frame.size.width, height: 30)
        info.backgroundColor = .clear
        info.font = UIFont(name: "HelveticaNeue", size: 12.0)
        info.textAlignment = .center
        info.textColor = .white
        info.text = "Tap on a field and enter username and password"
        view.insertSubview(info, belowSubview: loginButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width / 2
        flyRight.toValue = view.bounds.size.width / 2
        flyRight.duration = 0.5
        flyRight.fillMode = kCAFillModeBoth
        flyRight.isRemovedOnCompletion = false
        
        flyRight.delegate = self
        flyRight.setValue("form", forKey: "name")
        flyRight.setValue(headingLabel.layer, forKey: "layer")
        
        headingLabel.layer.add(flyRight, forKey: nil)
        
        flyRight.beginTime = CACurrentMediaTime() + 0.3
        flyRight.setValue(usernameTextField.layer, forKey: "layer")
        usernameTextField.layer.add(flyRight, forKey: nil)

        flyRight.beginTime = CACurrentMediaTime() + 0.4
        flyRight.setValue(passwordTextField.layer, forKey: "layer")
        passwordTextField.layer.add(flyRight, forKey: nil)
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
        
        usernameTextField.layer.position.x -= view.bounds.width
        passwordTextField.layer.position.x -= view.bounds.width
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.0
        opacity.toValue = 1.0
        opacity.duration = 0.5
        opacity.fillMode = kCAFillModeBackwards
        
        opacity.beginTime = CACurrentMediaTime() + 0.5
        cloud1ImageView.layer.add(opacity, forKey: nil)
        
        opacity.beginTime = CACurrentMediaTime() + 0.7
        cloud2ImageView.layer.add(opacity, forKey: nil)
        
        opacity.beginTime = CACurrentMediaTime() + 0.9
        cloud3ImageView.layer.add(opacity, forKey: nil)
        
        opacity.beginTime = CACurrentMediaTime() + 1.1
        cloud4ImageView.layer.add(opacity, forKey: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
        }, completion: nil)
        
        animateCloud(layer: cloud1ImageView.layer)
        animateCloud(layer: cloud2ImageView.layer)
        animateCloud(layer: cloud3ImageView.layer)
        animateCloud(layer: cloud4ImageView.layer)
        
        usernameTextField.layer.position.x = view.bounds.size.width / 2
        passwordTextField.layer.position.x = view.bounds.size.width / 2
        
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x + view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
        info.layer.add(flyLeft, forKey: "infoappear")
        
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.2
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 4.5
        info.layer.add(fadeLabelIn, forKey: "fadein")
        
        
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
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1.0
        }, completion: nil)
        
        let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
        tintBackgroundColor(layer: loginButton.layer, toColor: tintColor)
        
        roundCorners(layer: loginButton.layer, toRadius: 25.0)
    }
    
    // MARK: -
    
    func showMessage(index: Int) {
        statusLabel.text = statusMessages[index]
        
        UIView.transition(with: statusImageView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.statusImageView.isHidden = false
        }) { _ in
            delay(seconds: 1.5) {
                if index < self.statusMessages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    self.resetForm()
                }
            }
        }
    
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.statusImageView.center.x += self.view.frame.size.width
        }) { _ in
            self.statusImageView.isHidden = true
            self.statusImageView.center = self.statusImageViewPosition
            
            self.showMessage(index: index + 1)
        }
    }
    
    func resetForm() {
        UIView.transition(with: statusImageView, duration: 0.33, options: [.transitionFlipFromTop], animations: {
            self.statusImageView.isHidden = true
        }, completion: nil)
        
        UIView.animate(withDuration: 0.33, delay: 0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
        }) { _ in
            let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
            self.roundCorners(layer: self.loginButton.layer, toRadius: 10.0)
        }
        
    }
    
    func animateCloud(layer: CALayer) {
        // 1
        let cloudSpeed = 30.0 / Double(view.layer.frame.size.width)
        let duration: TimeInterval = Double(view.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        // 2
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.width + layer.bounds.width / 2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        layer.add(cloudMove, forKey: "nil")
    }
    
    func roundCorners(layer: CALayer, toRadius: CGFloat) {
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = layer.cornerRadius
        cornerAnimation.toValue = toRadius
        cornerAnimation.duration = 0.33
        layer.add(cornerAnimation, forKey: nil)
        layer.cornerRadius = toRadius
    }
}

extension LoginViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation did finish")
        
        guard let name = anim.value(forKey: "name") as? String else { return }
        
        if name == "form" {
            let layer = anim.value(forKey: "layer") as? CALayer
            anim.setValue(nil, forKey: "layer")
            
            let pulse = CABasicAnimation(keyPath: "transform.scale")
            pulse.fromValue = 1.25
            pulse.toValue = 1.0
            pulse.duration = 0.25
            layer?.add(pulse, forKey: nil)
        } else if name == "cloud" {
            guard let layer = anim.value(forKey: "layer") as? CALayer else { return }
            layer.position.x = -layer.bounds.width / 2
            
            delay(seconds: 0.2) {
                self.animateCloud(layer: layer)
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        info.layer.removeAnimation(forKey: "infoappear")
    }
    
}









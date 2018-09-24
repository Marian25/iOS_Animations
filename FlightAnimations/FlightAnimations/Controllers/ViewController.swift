//
//  ViewController.swift
//  FlightAnimations
//
//  Created by Marian Stanciulica on 24/09/2018.
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

class ViewController: UIViewController {

    enum AnimationDirection: Int {
        case positive = 1
        case negative = -1
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var summaryIcon: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var gateNumberLabel: UILabel!
    @IBOutlet weak var departingFromLabel: UILabel!
    @IBOutlet weak var arrivingToLabel: UILabel!
    @IBOutlet weak var planeImageView: UIImageView!
    @IBOutlet weak var flightStatusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    var snowView: SnowView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the Snow Effect Layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        self.changeFlight(to: londonToParis)
    }
    
    // MARK: - Animations methods

    func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
        }, completion: nil)
    
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.snowView.alpha = showEffects ? 1.0 : 0.0
        }, completion: nil)
    }
    
    func changeFlight(to data: FlightData, animated: Bool = false) {
        if animated {
            fade(imageView: backgroundImageView, toImage: UIImage(named: data.weatherImageName)!, showEffects: data.showWeatherEffects)
            
            let direction: AnimationDirection = data.isTakingOff ? .positive : .negative
            cubeTransition(label: flightNumberLabel, text: data.flightNumber, direction: direction)
            cubeTransition(label: gateNumberLabel, text: data.gateNumber, direction: direction)
            
            let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue) * 80.0, y: 0.0)
            let offsetArriving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue) * 50.0)
            
            moveLabel(label: departingFromLabel, text: data.departingFrom, offset: offsetDeparting)
            moveLabel(label: arrivingToLabel, text: data.arrivingTo, offset: offsetArriving)
            
        } else {
            backgroundImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
            
            flightNumberLabel.text = data.flightNumber
            gateNumberLabel.text = data.gateNumber
            
            departingFromLabel.text = data.departingFrom
            arrivingToLabel.text = data.arrivingTo
            
            flightStatusLabel.text = data.flightStatus
        }
        
        delay(seconds: 3.0) {
             self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor

        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: auxLabelOffset))
        
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: -auxLabelOffset))
        }) { _ in
            label.text = auxLabel.text
            label.transform = .identity
            
            auxLabel.removeFromSuperview()
        }
    }
    
    func moveLabel(label:UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }) { _ in
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        }
    }
    

}


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
        } else {
            backgroundImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
        }
        
        delay(seconds: 3.0) {
             self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    

}


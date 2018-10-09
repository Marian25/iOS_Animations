//
//  ViewController.swift
//  SnowAnimation
//
//  Created by Marian Stanciulica on 09/10/2018.
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
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var departingFrom: UILabel!
    @IBOutlet weak var arrivingTo: UILabel!
    @IBOutlet weak var gateNumber: UILabel!
    @IBOutlet weak var planeImage: UIImageView!
    @IBOutlet weak var statusBanner: UIImageView!
    @IBOutlet weak var flightStatus: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height / 2
        
        changeFlightDataTo(data: londonToParis)
    }

    func changeFlightDataTo(data: FlightData) {
        summary.text = data.summary
        flightNumber.text = data.flightNr
        gateNumber.text = data.gateNr
        departingFrom.text = data.departingFrom
        arrivingTo.text = data.arrivingTo
        flightStatus.text = data.flightStatus
        backgroundImageView.image = UIImage(named: data.weatherImageName)
    }
    
}


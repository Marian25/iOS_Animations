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

    let flakes = ["flake", "flake1", "flake2", "flake3", "flake4"]
    
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
        
        let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width, height: 50.0)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        view.layer.addSublayer(emitter)
        
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
        emitter.emitterPosition = CGPoint(x: rect.width / 2, y: rect.height / 2)
        emitter.emitterSize = rect.size
        
        for flake in flakes {
            let emitterCell = makeEmitterCell(with: flake)
            if emitter.emitterCells == nil {
                emitter.emitterCells = [emitterCell]
            } else {
                emitter.emitterCells!.append(emitterCell)
            }
        }
    }
    
    func makeEmitterCell(with imageNamed: String) -> CAEmitterCell {
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: imageNamed)?.cgImage
        emitterCell.birthRate = 50
        emitterCell.lifetime = 3.5
        emitterCell.yAcceleration = 70.0
        emitterCell.xAcceleration = 10.0
        emitterCell.velocity = 20.0
        emitterCell.emissionLongitude = -.pi
        emitterCell.velocityRange = 200.0
        emitterCell.emissionRange = .pi * 0.5
        emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        emitterCell.redRange = 0.1
        emitterCell.greenRange = 0.1
        emitterCell.blueRange = 0.1
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15
        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        emitterCell.lifetimeRange = 1.0
        return emitterCell
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


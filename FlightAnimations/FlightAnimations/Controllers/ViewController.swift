//
//  ViewController.swift
//  FlightAnimations
//
//  Created by Marian Stanciulica on 24/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


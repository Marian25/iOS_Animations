//
//  ViewController.swift
//  IrisAnimations
//
//  Created by Marian Stanciulica on 28/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var speakButton: UIButton!
    
    let replicatorLayer = CAReplicatorLayer()
    let dot = CALayer()
    
    let monitor = MicMonitor()
    let assistant = Assistant()
    
    let dotLength: CGFloat = 6.0
    let dotOffset: CGFloat = 8.0
    var lastTransformScale: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func actionStartMonitoring(_ sender: UIButton) {
    }
    
    @IBAction func actionEndMonitoring(_ sender: UIButton) {
    }
    
    func startSpeaking() {
        
    }
    
}


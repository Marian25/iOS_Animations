//
//  ViewController.swift
//  IrisAnimations
//
//  Created by Marian Stanciulica on 28/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Delay Function
func delay(seconds: Double, completion: @escaping () -> ()) {
    let milliseconds = Int(1000 * seconds)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
        completion()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var speakButton: UIButton!
    
    let replicator = CAReplicatorLayer()
    let dot = CALayer()
    
    let monitor = MicMonitor()
    let assistant = Assistant()
    
    let dotLength: CGFloat = 6.0
    let dotOffset: CGFloat = 8.0
    var lastTransformScale: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replicator.frame = view.bounds
        view.layer.addSublayer(replicator)
        
        dot.frame = CGRect(x: replicator.frame.size.width - dotLength,
                           y: replicator.position.y,
                           width: dotLength,
                           height: dotLength)
        dot.backgroundColor = UIColor.gray.cgColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        dot.borderWidth = 0.5
        dot.cornerRadius = 1.5
        
        replicator.addSublayer(dot)
        
        replicator.instanceCount = Int(view.frame.size.width / dotOffset)
        replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
        replicator.instanceDelay = 0.02
    }


    @IBAction func actionStartMonitoring(_ sender: UIButton) {
        dot.backgroundColor = UIColor.green.cgColor
        monitor.startMonitoringWithHandler { level in
            self.meterLabel.text = String(format: "%.2f db", level)
            let scaleFactor = max(0.2, CGFloat(level) + 50) / 2
            
            let scale = CABasicAnimation(keyPath: "transform.scale.y")
            scale.fromValue = self.lastTransformScale
            scale.toValue = scaleFactor
            scale.duration = 0.1
            scale.isRemovedOnCompletion = false
            scale.fillMode = .forwards
            self.dot.add(scale, forKey: nil)
            self.lastTransformScale = scaleFactor
        }
    }
    
    @IBAction func actionEndMonitoring(_ sender: UIButton) {
        monitor.stopMonitoring()
        
        let scaleBack = CABasicAnimation(keyPath: "transform.scale.y")
        scaleBack.fromValue = lastTransformScale
        scaleBack.toValue = 1.0
        scaleBack.duration = 0.2
        scaleBack.fillMode = .forwards
        scaleBack.isRemovedOnCompletion = false
        dot.add(scaleBack, forKey: nil)
        
        dot.backgroundColor = UIColor.magenta.cgColor
        
        let tintBack = CABasicAnimation(keyPath: "backgroundColor")
        tintBack.fromValue = UIColor.green.cgColor
        tintBack.toValue = UIColor.magenta.cgColor
        tintBack.duration = 1.2
        tintBack.fillMode = .backwards
        dot.add(tintBack, forKey: nil)
        
        delay(seconds: 1.0) {
            self.startSpeaking()
        }
    }
    
    func startSpeaking() {
        meterLabel.text = assistant.randomAnswer()
        assistant.speack(meterLabel.text!, completion: endSpeaking)
        speakButton.isHidden = true
        
        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scale.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1.4, 15, 1.0))
        scale.duration = 0.33
        scale.repeatCount = .infinity
        scale.autoreverses = true
        scale.timingFunction = CAMediaTimingFunction(name: .easeOut)
        dot.add(scale, forKey: "dotScale")
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.duration = 0.33
        fade.beginTime = CACurrentMediaTime() + 0.33
        fade.repeatCount = .infinity
        fade.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name: .easeOut)
        dot.add(fade, forKey: "dotOpacity")
        
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.magenta.cgColor
        tint.toValue = UIColor.cyan.cgColor
        tint.duration = 0.66
        tint.beginTime = CACurrentMediaTime() + 0.28
        tint.fillMode = .backwards
        tint.repeatCount = .infinity
        tint.autoreverses = true
        tint.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        dot.add(tint, forKey: "dotColor")
        
        let initialRotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        initialRotation.fromValue = 0.0
        initialRotation.toValue = 0.01
        initialRotation.duration = 0.33
        initialRotation.isRemovedOnCompletion = false
        initialRotation.fillMode = .forwards
        initialRotation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        replicator.add(initialRotation, forKey: "initialRotation")
        
        let rotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        rotation.fromValue = 0.01
        rotation.toValue = -0.01
        rotation.duration = 0.99
        rotation.beginTime = CACurrentMediaTime() + 0.33
        rotation.repeatCount = .infinity
        rotation.autoreverses = true
        rotation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        replicator.add(rotation, forKey: "replicatorRotation")
    }
    
    func endSpeaking() {
        replicator.removeAllAnimations()
        
        let scale = CABasicAnimation(keyPath: "transform")
        scale.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        scale.duration = 0.33
        scale.isRemovedOnCompletion = false
        scale.fillMode = .forwards
        dot.add(scale, forKey: nil)
        
        dot.removeAnimation(forKey: "dotColor")
        dot.removeAnimation(forKey: "dotOpacity")
        dot.backgroundColor = UIColor.lightGray.cgColor
        speakButton.isHidden = false
    }
    
}


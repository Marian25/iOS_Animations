//
//  ViewController.swift
//  ShapeMorphing
//
//  Created by Marian Stanciulica on 27/09/2018.
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

    @IBOutlet weak var myAvatar: AvatarView!
    @IBOutlet weak var opponentAvatar: AvatarView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var searchAgainButton: UIButton!
    @IBOutlet weak var vsLabel: UILabel!
    
    let arialRounded = UIFont(name: "ArialRoundedMTBold", size: 36.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        myAvatar.name = "Me"
        myAvatar.image = UIImage(named: "avatar-1")
        
        statusLabel.font = arialRounded
        vsLabel.font = arialRounded
        searchAgainButton.titleLabel?.font = arialRounded
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchForOpponent()
    }

    func searchForOpponent() {
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = avatarSize.width / 1.9
        let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
        let rightBouncePoint = CGPoint(x: view.frame.size.width / 2.0 + bounceXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width / 2.0 - bounceXOffset, y: myAvatar.center.y)
        
        myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
    }
    
    
    @IBAction func actionSearchAgain(_ sender: UIButton) {
    
    }
}


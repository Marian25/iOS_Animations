//
//  FooterCell.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 04/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    var didPressEdit: ( () -> Void )?
    
    @IBAction func edit(_ sender: Any) {
        didPressEdit?()
    }
}

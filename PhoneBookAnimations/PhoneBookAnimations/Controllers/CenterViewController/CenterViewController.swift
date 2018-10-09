//
//  ViewController.swift
//  PhoneBookAnimations
//
//  Created by Marian Stanciulica on 09/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    @IBOutlet weak var symbol: UILabel!
    
    var menuButton: MenuButton!
    
    var menuItem: MenuItem! {
        didSet {
            title = menuItem.title
            view.backgroundColor = menuItem.color
            symbol.text = menuItem.symbol
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton = MenuButton()
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parent as? ContainerViewController {
                containerVC.toggleSideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuItem = MenuItem.sharedItems.first!
    }

}


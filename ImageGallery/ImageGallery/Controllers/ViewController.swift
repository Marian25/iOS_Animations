//
//  ViewController.swift
//  ImageGallery
//
//  Created by Marian Stanciulica on 09/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let images = [
        ImageViewCard(imageNamed: "Hurricane_Katia", title: "Hurricane Katia"),
        ImageViewCard(imageNamed: "Hurricane_Douglas", title: "Hurricane Douglas"),
        ImageViewCard(imageNamed: "Hurricane_Norbert", title: "Hurricane Norbert"),
        ImageViewCard(imageNamed: "Hurricane_Irene", title: "Hurricane Irene")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "info", style: .done, target: self, action: #selector(info))
    }

    @objc func info() {
        let alertController = UIAlertController(title: "Info", message: "Public Domain images by NASA", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}


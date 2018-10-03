//
//  DetailTableViewController.swift
//  LogoReveal
//
//  Created by Marian Stanciulica on 02/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    weak var transition: RevealAnimator?
    let packItems = ["Ice cream money", "Great weather", "Beach ball", "Swimsuit for him", "Swimsuit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pack List"
        tableView.rowHeight = 54.0
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        view.addGestureRecognizer(pan)
    }
    
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            transition!.interactive = true
            navigationController?.popViewController(animated: true)
        default:
            transition!.handlePan(recognizer: recognizer)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.text = packItems[indexPath.row]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\((indexPath as NSIndexPath).row).png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

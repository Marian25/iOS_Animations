//
//  SettingsViewController.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 08/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var items = ["Add Weather", "Add Stocks", "Add Clock", "Cancel"]
    var didDismiss: (() -> Void)?

}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = UIColor.white.withAlphaComponent(0.9)
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: didDismiss)
    }
    
}

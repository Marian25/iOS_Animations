//
//  WidgetCell.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 04/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class WidgetCell: UITableViewCell {

    @IBOutlet weak var widgetView: WidgetView!
    @IBOutlet weak var widgetHeight: NSLayoutConstraint!
    
    private var showsMore = false
    weak var tableView: UITableView?
    
    var owner: WidgetsOwnerProtocol? {
        didSet {
            if let owner = owner {
                widgetView.owner = owner
            }
        }
    }
    
    @IBAction func toggleShowMore(_ sender: UIButton) {
        self.showsMore = !self.showsMore
        
        self.widgetHeight.constant = self.showsMore ? 230 : 130
        self.tableView?.reloadData()
        
        widgetView.expanded = showsMore
        widgetView.reload()
    }
    
}

//
//  ViewController.swift
//  PackingListAnimations
//
//  Created by Marian Stanciulica on 24/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    private var slider: HorizontalItemList!
    private var isMenuOpen = false
    private var items: [Int] = [5, 6, 7]
    private let itemTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionToggleMenu(_ sender: AnyObject) {
        isMenuOpen = !isMenuOpen
        
        titleLabel.superview?.constraints.forEach({ constraint in
            if constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX {
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                return
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                
                let newContraint = NSLayoutConstraint (item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: isMenuOpen ? 0.67 : 1.0, constant: 5.0)
                newContraint.identifier = "TitleCenterY"
                newContraint.isActive = true
                
            }
        })
        
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
        titleLabel.text = isMenuOpen ? "Select Item" : "Packing List"
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()

            let angle: CGFloat = self.isMenuOpen ? .pi / 4 : 0.0
            self.menuButton.transform = CGAffineTransform(rotationAngle: angle)
        }, completion: nil)
        
        if isMenuOpen {
            slider  = HorizontalItemList(inView: view)
            slider.didSelectItem = { index in
                self.items.append(index)
                self.tableView.reloadData()
                self.actionToggleMenu(self)
            }
            self.titleLabel.superview?.addSubview(slider)
        } else {
            slider.removeFromSuperview()
        }
    }
    
    private func showItem(index: Int) {
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let constraintX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let constraintBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let constraintWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50.0)
        let constraintHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        NSLayoutConstraint.activate([constraintX, constraintBottom, constraintWidth, constraintHeight])
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            constraintBottom.constant = -imageView.frame.size.height / 2.0
            constraintWidth.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 1.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            constraintBottom.constant = imageView.frame.height * 1.5
            self.view.layoutIfNeeded()
        }, completion: { _ in
            imageView.removeFromSuperview()
        })
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItem(index: items[indexPath.row])
    }
    
}


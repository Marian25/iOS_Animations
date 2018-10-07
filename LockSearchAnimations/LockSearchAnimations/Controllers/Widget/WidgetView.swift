//
//  WidgetView.swift
//  LockSearchAnimations
//
//  Created by Marian Stanciulica on 04/10/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class WidgetView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items: [String] = ["Bahama Air", "PackMe", "Fight", "Slide", "Iris", "Herbs", "Reveal", "Office"]
    
    var previewInteraction: UIPreviewInteraction?
    var owner: WidgetsOwnerProtocol!
    
    var expanded = false
    
    func reload() {
        collectionView.reloadData()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard let _ = superview else {
            previewInteraction?.delegate = nil
            return
        }
        
        previewInteraction = UIPreviewInteraction(view: collectionView)
        previewInteraction?.delegate = self
    }
}

extension WidgetView: UIPreviewInteractionDelegate {
    public func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        owner.cancelPreview()
    }
    
    func previewInteractionShouldBegin(_ previewInteraction: UIPreviewInteraction) -> Bool {
        
        if let indexPath = collectionView?.indexPathForItem(at: previewInteraction.location(in: collectionView!)),
            let cell = collectionView?.cellForItem(at: indexPath) as? IconCell {
            
            owner.startPreview(for: cell.icon)
        }
        return true
    }
    
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        owner.updatePreview(percent: transitionProgress)
        
        if ended {
            owner.finishPreview()
        }
    }
    
}

extension WidgetView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expanded ? 8 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IconCell
        cell.name.text = items[indexPath.row]
        cell.icon.image = UIImage(named: "icon\(indexPath.row+1)")
        return cell
    }
}

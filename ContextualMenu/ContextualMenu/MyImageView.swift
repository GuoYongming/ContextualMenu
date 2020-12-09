//
//  MyImageView.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit

class MyImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addMenuInteraction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        addInteraction(interaction)
    }
}

extension MyImageView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
       
        return ImageContextMenuConfiguration.createInstance(0, image)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//        animator.addCompletion { [weak self] in
//            if let this = self {
//                let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
//                detailVC.image = image
//                this.show(detailVC, sender: nil)
//            }
//
//        }
    }
    
}

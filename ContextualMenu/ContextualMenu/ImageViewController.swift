//
//  ImageViewController.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit

class ImageViewController: UIViewController {

    lazy var imageView: MyImageView = {
        let iView = MyImageView(frame: CGRect(x: 50, y: 130, width: UIScreen.main.bounds.size.width - 100, height: 360))
        iView.contentMode = .scaleAspectFit
        iView.clipsToBounds = true
        iView.image = UIImage(named: "image_0.jpg")
        return iView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - 80)/2, y: 530, width: 80, height: 50))
        button.setTitle("预览图片", for: .normal)
        button.backgroundColor = UIColor.cyan
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let interaction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(interaction)
        view.addSubview(button)
        view.addSubview(imageView)
    }
    
    func createContextMenuActions() -> UIMenu {
        // 二级action数组
        var ratingActions: Array<UIMenuElement> = []
        // 遍历增加5个action
        for i in 0..<5 {
            let action = UIAction(title: "\(i+1) 分") { (action) in
            }
            ratingActions.append(action)
        }
        // 创建一个打分的菜单
        let ratingMenu = UIMenu(title: "打分", image: UIImage(systemName: "star.circle"), children: ratingActions)
        
        let favoriteAction = UIAction(title: "喜欢", image: UIImage(systemName: "heart.fill"), state: .off) { (action) in

        }
        let shareAction = UIAction(title: "分享", image: UIImage(systemName: "square.and.arrow.up.fill"), state: .off) { (action) in
        }
        
        let deleteAction = UIAction(title: "删除", image: UIImage(systemName: "trash.fill"),
                                    attributes: [.destructive], state: .off) { (action) in
        }
        // 创建一个delete menu，然后设置options属性为displayInline，并将上面的deleteAction添加进来。
        let deleteMenu = UIMenu(title: "删除菜单", options: .displayInline, children: [deleteAction])
        // 将打分的菜单放到一级菜单里面。
        return UIMenu(title: "菜单", children: [ratingMenu, favoriteAction, shareAction, deleteMenu])
    }
    
}

extension ImageViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil) { [weak self] () -> UIViewController? in
            // 创建预览视图，并返回。
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.image = self?.imageView.image
            // 预览视图显示大小
            detailVC.preferredContentSize = CGSize(width: 280, height: 360)
            return detailVC
        } actionProvider: { [weak self]  (elements) -> UIMenu? in
            return self?.createContextMenuActions()
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        animator.addCompletion { [weak self] in
            if let this = self {
                let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
                detailVC.image = this.button.imageView?.image
                this.show(detailVC, sender: nil)
            }
        }
    }
    
}

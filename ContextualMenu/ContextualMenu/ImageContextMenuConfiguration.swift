//
//  ImageContextMenuConfiguration.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit

class ImageContextMenuConfiguration {
    static func createInstance(_ indentifier: Int, _ image: UIImage?) -> UIContextMenuConfiguration {
        let configuration = UIContextMenuConfiguration(identifier: String(indentifier) as NSCopying) { () -> UIViewController? in
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.image = image
            detailVC.preferredContentSize = CGSize(width: 280, height: 360)
            return detailVC
        } actionProvider: { (elements) -> UIMenu? in
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
        return configuration
    }
}

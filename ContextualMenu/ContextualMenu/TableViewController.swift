//
//  TableViewController.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit

class TableViewController: UITableViewController {
        
    var imageArray = ["image_0.jpg", "image_1.jpg", "image_2.jpg", "image_3.jpg", "image_4.jpg", "image_5.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell

        cell?.customImageView.image = UIImage(named: imageArray[indexPath.row])
        cell?.titleLabel.text = imageArray[indexPath.row]

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.image = UIImage(named: imageArray[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let image = UIImage(named: imageArray[indexPath.row])
        return ImageContextMenuConfiguration.createInstance(indexPath.row, image)
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        if let index = Int(configuration.identifier as! String) {
            animator.addCompletion {[weak self]in
                let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
                if let imageName = self?.imageArray[index] {
                    detailVC.image = UIImage(named: imageName)
                }
                self?.show(detailVC, sender: nil)
            }
        }
    }
}

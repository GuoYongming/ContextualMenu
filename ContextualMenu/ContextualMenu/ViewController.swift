//
//  ViewController.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func image(_ sender: Any) {
        let imageVC = ImageViewController()
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
    

    @IBAction func tableView(_ sender: Any) {
        let tableViewVC = TableViewController(nibName: "TableViewController", bundle: nil)
        self.navigationController?.pushViewController(tableViewVC, animated: true)
    }
    
    @IBAction func collectionView(_ sender: Any) {
        let collectionViewVC = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
        self.navigationController?.pushViewController(collectionViewVC, animated: true)
    }
}


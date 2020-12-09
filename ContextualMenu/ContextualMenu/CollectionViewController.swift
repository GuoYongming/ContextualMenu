//
//  CollectionViewController.swift
//  ContextualMenu
//
//  Created by GuoYongming on 2020/12/8.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    
    var imageArray = ["image_0.jpg", "image_1.jpg", "image_2.jpg", "image_3.jpg", "image_4.jpg", "image_5.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.backgroundColor = UIColor.white
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell
        cell?.customImageView.image = UIImage(named: imageArray[indexPath.row])
        cell?.titleLabel.text = imageArray[indexPath.row]
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.image = UIImage(named: imageArray[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let image = UIImage(named: imageArray[indexPath.row])
        return ImageContextMenuConfiguration.createInstance(indexPath.row, image)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
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

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 60)/3
        let height = width*3/2 + 20
        return CGSize(width: width, height: height)
    }
}

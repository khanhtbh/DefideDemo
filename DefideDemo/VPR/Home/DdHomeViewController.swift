//
//  ViewController.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdHomeViewController: UIViewController {
    
    let numberOfCol: CGFloat = 3
    let spacing: CGFloat = 3
    
    @IBOutlet weak var photoCollectionView: UICollectionView! {
        didSet {
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
            photoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
            let photoFlowLayout = DdPhotoFlowLayout()
            photoFlowLayout.scrollDirection = .vertical
            photoFlowLayout.cellSpacing = spacing
            photoFlowLayout.minCellWidth = (DdGuiConstant.screenWidth - (numberOfCol - 1) * spacing) / numberOfCol
            photoFlowLayout.minimumLineSpacing = spacing
            photoFlowLayout.minimumInteritemSpacing = spacing
            photoCollectionView.collectionViewLayout = photoFlowLayout
        }
    }
    
    var photos: Array<DdPhoto> = []
    
    var presentor: DdHomePresentor? {
        didSet {
            presentor?.viewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Home"
        presentor = DdHomePresentor()
        
        presentor?.loadPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DdHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DdImageCollectionViewCell.cellId, for: indexPath) as! DdImageCollectionViewCell
        cell.photo = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = (DdGuiConstant.screenWidth - (numberOfCol - 1) * spacing) / numberOfCol
        if indexPath.row % 6 == 4 {
            cellWidth = cellWidth * 2 + spacing
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleIndexPaths = photoCollectionView.indexPathsForVisibleItems
        visibleIndexPaths = visibleIndexPaths.sorted(by: { (idx1, idx2) -> Bool in
            idx1.row > idx2.row
        })
        if let lastIndexPath = visibleIndexPaths.first {
            if lastIndexPath.row == self.photos.count - 1 {
                self.presentor?.loadPhotos()
            }
        }
    }
}



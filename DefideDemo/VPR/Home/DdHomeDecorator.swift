//
//  DdHomeDecorator.swift
//  DefideDemo
//
//  Created by Kei on 3/10/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdHomeDecorator: Decorator<DdHomeViewController> {
    override func decorViewController() {
        decorCollectionView()
    }
    
    func decorCollectionView() {
        viewController.photoCollectionView.delegate = viewController
        viewController.photoCollectionView.dataSource = viewController
        viewController.photoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        let photoFlowLayout = DdPhotoFlowLayout()
        photoFlowLayout.scrollDirection = .vertical
        photoFlowLayout.cellSpacing = viewController.spacing
        photoFlowLayout.minCellWidth = (DdGuiConstant.screenWidth - (viewController.numberOfCol - 1) * viewController.spacing) / viewController.numberOfCol
        photoFlowLayout.minimumLineSpacing = viewController.spacing
        photoFlowLayout.minimumInteritemSpacing = viewController.spacing
        viewController.photoCollectionView.collectionViewLayout = photoFlowLayout
    }
}

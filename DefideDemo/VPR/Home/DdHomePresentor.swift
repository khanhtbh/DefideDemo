//
//  DdHomePresentor.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdHomePresentor: Presentor<DdHomeViewController> {
    
    var page: Int = 1
    var numberPerPage = 12
    var orderBy: DdPhotoOrderBy = .oldest
    var canLoadMore: Bool = true
    let photoInteractor = DdPhotoInteractor()
    
    func loadPhotos() {
        guard canLoadMore else {return}
        photoInteractor.listPhotos(page: page, numberPerPage: numberPerPage, orderBy: orderBy) { [weak self] (success, error, photos) in
            if success {
                self?.viewController.photos.append(contentsOf: photos)
                self?.viewController.photoCollectionView.reloadData()
                
            }
            self?.canLoadMore = success && photos.count == self?.numberPerPage
            if success && photos.count == self?.numberPerPage {
                self?.page += 1
            }
        }
    }
}

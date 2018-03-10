//
//  DdPhotoDetailPresentor.swift
//  DefideDemo
//
//  Created by Kei on 3/10/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import AlamofireImage

class DdPhotoDetailPresentor: Presentor<DdPhotoDetailViewController> {
    func loadPhoto() {
        if let url = viewController.photo.getUrl(resolution: .full) {
            viewController.imageView.af_setImage(withURL: url, completion: { [weak self] (dataRes) in
                self?.viewController.view.setNeedsLayout()
                self?.viewController.view.layoutIfNeeded()
            })
        }
    }
}

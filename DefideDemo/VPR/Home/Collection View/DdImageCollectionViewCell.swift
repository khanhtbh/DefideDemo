//
//  DdImageCollectionViewCell.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import AlamofireImage

class DdImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "DdImageCollectionViewCell"
    
    var photo: DdPhoto! {
        didSet {
            if let url = photo.getUrl(resolution: .thumb) {
                imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder") )
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
}

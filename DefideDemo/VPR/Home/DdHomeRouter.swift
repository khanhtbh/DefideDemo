//
//  DdHomeRouter.swift
//  DefideDemo
//
//  Created by Kei on 3/10/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdHomeRouter: Router<DdHomeViewController>, SeguePreparation {
    
    private var openingPhoto: DdPhoto!
    
    func openPhotoDetail(photo: DdPhoto) {
        openingPhoto = photo
        viewController.performSegue(withIdentifier: "home_photoDetail", sender: self)
    }
    
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "home_photoDetail" {
            let photoDetailViewController = segue.destination as! DdPhotoDetailViewController
            photoDetailViewController.photo = openingPhoto
        }
    }
}

//
//  DdPhotoInteractor.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdPhotoInteractor: NSObject {
    func listPhotos(page: Int, numberPerPage: Int, orderBy: DdPhotoOrderBy, completion: @escaping (_ success: Bool, _ error: Error?, _ photos: Array<DdPhoto>) -> ()) {
        DdApi.listPhotos(page: page, numberPerPage: numberPerPage, orderBy: orderBy)
            .responds { (success, error, response) in
                var photos = Array<DdPhoto>()
                if success, let responseArr = response?.array {
                    photos = responseArr.map { DdPhoto(json: $0) }
                }
                completion(success, error, photos)
        }
    }
}

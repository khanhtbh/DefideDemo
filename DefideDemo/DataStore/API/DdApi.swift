//
//  DdApi.swift
//  DdSplash
//
//  Created by Kei on 3/8/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdApi: NSObject {
    
    class func addClientId(request: DdApiRequest) {
        if var params = request.requestParams {
            params["client_id"] = DdConstants.appId
            request.requestParams = params
        } else {
            request.requestParams = [
                "client_id": DdConstants.appId
            ]
        }
    }
    
    class func listPhotos(page: Int, numberPerPage: Int, orderBy: DdPhotoOrderBy) -> DdApiRequest {
        let request = DdApiRequest()
        request.api = UnsplashApiUrl.photos
        request.requestParams = [
            "page": page,
            "per_page": numberPerPage,
            "order_by": orderBy.rawValue
        ]
        addClientId(request: request)
        request.requestMethod = .get
        return request
    }
}

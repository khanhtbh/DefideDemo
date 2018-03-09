//
//  DdApiRequest.swift
//  DefideDemo
//
//  Created by Kei on 3/5/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DdApiRequest: NSObject {
    /// The API
    var api = UnsplashApiUrl.unknown
    
    /// The request
    var request:URLRequest? = nil
    
    var requestMethod:HTTPMethod = .get
    
    /// True if app needs display an indicator for this request
    var requireIndicator:Bool = true
    
    /// Request params
    var requestParams:[String:Any]? = nil
    
    /// Request headers
    var requestHeaders:[String:String] = [
        "content-type": "application/json; charset=UTF-8",
        "cache-control": "no-cache"
    ]
    
    var requiredAuthorization = false
    
    var authorization = ""
    var dataRequest: DataRequest?
    
    /// Response block which wraps the response closure of Alamofire
    var response:((Bool, Error?, JSON?) -> ())?
    
    override init() {
        super.init()
    }
    
    func fullRequestURL() -> String {
        var url = api
        if (requestMethod == .get) {
            if let params = requestParams {
                url = url + "?"
                for (param, value) in params {
                    url = url + param + "=" + String(describing: value) + "&"
                }
            }
        }
        return url
    }
    
    func responds(completion: @escaping (Bool, Error?, JSON?) -> ()) {
        response = completion
        DdApiRequestor.sharedRequestor.startRequest(self)
    }
}

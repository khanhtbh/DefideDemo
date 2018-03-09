//
//  DdApiRequestor.swift
//  DefideDemo
//
//  Created by Kei on 3/5/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DdApiRequestor: NSObject {
    var requests:Array<DdApiRequest> = []
    
    static let sharedRequestor = DdApiRequestor()
    
    private override init() {}
    
    func startRequest(_ request: DdApiRequest) {
        
        
        var headers = request.requestHeaders
        if request.authorization.count > 0 {
            headers["Authorization"] = request.authorization
        }
        
        print("Request to URL", request.fullRequestURL(), "\nHeader",
              headers.description, "\nParams:",
              request.requestParams?.description ?? "")
        
         self.performRequest(request: request, headers: headers)
        
    }
    
    private func performRequest(request: DdApiRequest, headers: [String:String]) {
        request.dataRequest = Alamofire.request(request.fullRequestURL(), method: request.requestMethod, parameters: request.requestParams, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    
                    print("Response of URL", request.fullRequestURL(), "\nHeaders: ",
                          headers.description , "\nData:",
                          (data as AnyObject).description ?? "")
                    
                    let responseJson = JSON(data)
                    if let errors = responseJson["errors"].arrayObject {
                        let error = NSError.init(domain: "Unsplash", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: errors
                            ])
                        request.response?(false, error, nil)
                    } else {
                        request.response?(true, nil, responseJson)
                    }
                }
                break
                
            case .failure(let error):
                
                request.response?(false, error, nil)
                break
            }
        }
    }
}

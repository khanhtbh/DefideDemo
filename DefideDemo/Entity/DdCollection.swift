//
//  DdCollection.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import SwiftyJSON

enum DdCollectionLinkType: String {
    case this = "self"
    case html = "html"
    case photos = "photos"
}

class DdCollection: NSObject {
    var id: String!
    var title: String!
    var publishedAt: String!
    var updatedAt: String!
    var curated: Bool = false
    var coverPhoto: DdPhoto?
    var user: DdUser!
    var links: JSON!
    
    init(json: JSON) {
        super.init()
        id = json["id"].stringValue
        title = json["title"].stringValue
        publishedAt = json["pushlished_at"].stringValue
        updatedAt = json["updated_at"].stringValue
        curated = json["curated"].boolValue
        coverPhoto = DdPhoto(json: json["cover_photo"])
        user = DdUser(json: json["user"])
        links = json["links"]
    }
}

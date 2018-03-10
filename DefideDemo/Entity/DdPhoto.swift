//
//  DdPhoto.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import SwiftyJSON

enum DdPhotoOrderBy: String {
    case latest = "latest"
    case oldest = "oldest"
    case popular = "popular"
}

enum DdPhotoResolution: String {
    case raw = "raw"
    case full = "full"
    case regular = "regular"
    case small = "small"
    case thumb = "thumb"
}

enum DdPhotoLinkType: String {
    case this = "self"
    case html = "html"
    case download = "download"
    case downloadLocation = "download_location"
}

class DdPhoto: NSObject {
    var id: String!
    var createdAt: String!
    var updatedAt: String!
    var width: Float = 0
    var height: Float = 0
    var color: String = ""
    var likes: Int = 0
    var likedByUser: Bool = false
    var photoDesc: String = ""
    var urls: JSON = [:]
    var links: JSON = [:]
    
    var user: DdUser!
    var collections: [DdCollection] = []
    
    init(json: JSON) {
        super.init()
        id = json["id"].stringValue
        createdAt = json["created_at"].stringValue
        updatedAt = json["updated_at"].stringValue
        width = json["width"].floatValue
        height = json["height"].floatValue
        color = json["color"].stringValue
        likes = json["likes"].intValue
        likedByUser = json["liked_by_user"].boolValue
        photoDesc = json["description"].stringValue
        urls = json["urls"]
        links = json["links"]
        
        user = DdUser(json: json["user"])
        collections = json["current_user_collections"].arrayValue.flatMap { DdCollection(json: $0) }
    }
    
    func getUrl(resolution: DdPhotoResolution) -> URL? {
        return URL(string: urls[resolution.rawValue].stringValue)
    }
}

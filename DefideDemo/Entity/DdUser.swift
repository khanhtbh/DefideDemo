//
//  DdUser.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit
import SwiftyJSON

enum DdUserProfileResolution: String {
    case small = "small"
    case medium = "medium"
    case large = "large"
}

enum DdUserLinkType: String {
    case this = "self"
    case html = "html"
    case photos = "photos"
    case likes = "likes"
    case portfolio = "portfolio"
}

class DdUser: NSObject {
    var id: String!
    var username: String!
    var name: String!
    var portfolioUrl: String?
    var bio: String?
    var location: String?
    var totalLikes: Int = 0
    var totalPhotos: Int = 0
    var totalCollections: Int = 0
    var instagramUsername: String?
    var twitterUsername: String?
    var profileImage: JSON!
    var links: JSON!
    
    init(json: JSON) {
        super.init()
        id = json["id"].stringValue
        username = json["username"].stringValue
        name = json["name"].stringValue
        portfolioUrl = json["portfolio_url"].string
        bio = json["bio"].string
        location = json["location"].string
        totalLikes = json["total_likes"].intValue
        totalPhotos = json["total_photos"].intValue
        totalCollections = json["total_collections"].intValue
        instagramUsername = json["instagram_username"].string
        twitterUsername = json["twitter_username"].string
        profileImage = json["profile_image"]
        links = json["links"]
    }
    
    func getProfileImageUrl(resolution: DdUserProfileResolution) -> URL? {
        return URL(string: profileImage[resolution.rawValue].stringValue)
    }
}

//
//  JsonUser.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct JsonUser: Decodable {
    
    let username: String
    let name: String
    let country: String?
    let city: String?
    let biog: String?
    let favoriteCount: Int
    let followerCount: Int
    let followingCount: Int
    let pictures: Pictures
    
    
    private enum CodingKeys: CodingKey {
        case username
        case name
        case country
        case city
        case biog
        case favoriteCount
        case followerCount
        case followingCount
        case pictures
    }
    
    struct Pictures: Decodable {
        let large: URL?
    }
}

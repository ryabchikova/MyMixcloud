//
//  User.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let identifier: String     
    let name: String
    let country: String
    let city: String
    let bio: String
    let favoritesCount: Int
    let followersCount: Int
    let followingCount: Int
    private let pictures: Pictures
    
    var profileImage: URL? {
        return pictures.large
    }
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "username"
        case name
        case country
        case city
        case bio = "biog"
        case favoritesCount = "favorite_count"
        case followersCount = "follower_count"
        case followingCount = "following_count"
        case pictures
    }

    private struct Pictures: Decodable {
        let large: URL?
    }
}

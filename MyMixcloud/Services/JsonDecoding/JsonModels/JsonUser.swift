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
    let cloudcastCount: Int
    let pictures: Pictures
    let coverPictures: CoverPictures?
        
    struct Pictures: Decodable {
        let large: URL?
    }
    
    struct CoverPictures: Decodable {
        let small: URL?
        
        private enum CodingKeys: String, CodingKey {
            case small = "835wx120h"
        }
    }
}

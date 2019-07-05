//
//  JsonFollowing.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct JsonFollowing: Decodable {
    
    let users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case users = "data"
    }
    
    struct User: Decodable {
        let username: String
    }
}

//
//  JsonTrack.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct JsonTrack: Decodable {
    let tags: [JsonTag]
    let playCount: Int
    let user: User
    let key: String                 // unic id
    let createdTime: String         //format: 2019-03-13T19:03:02Z
    let audioLength: Int
    let favoriteCount: Int
    let listenerCount: Int
    let name: String
    let pictures: Pictures
    let repostCount: Int
    let listenTime: String?
        
    struct User: Decodable {
        let username: String        // unic id
        let name: String
    }
    
    struct Pictures: Decodable {
        let large: URL?
    }
}



//
//  Track.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct Track {
    let identifier: String
    let title: String
    let coverImage: URL?
    let user: (identifier: String, name: String)
    let tags: [Tag]
    let playCount: Int
    let createdTime: String
    let listenTime: String?
    let audioLength: String
    let favoriteCount: Int
    let listenerCount: Int
    let repostCount: Int
}

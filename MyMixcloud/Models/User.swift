//
//  User.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct User {
    let identifier: String     
    let name: String
    let country: String?
    let city: String?
    let bio: String?
    let favoritesCount: Int
    let followersCount: Int
    let followingCount: Int
    let profileImage: URL?
    let coverImage: URL?
}

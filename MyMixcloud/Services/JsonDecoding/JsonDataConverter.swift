//
//  JsonDataConverter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class JsonDataConverter {
    func makeUser(from jsonUser: JsonUser) -> User {
        return User(identifier: jsonUser.username,
                    name: jsonUser.name,
                    country: jsonUser.country,
                    city: jsonUser.city,
                    bio: jsonUser.biog,
                    favoritesCount: jsonUser.favoriteCount,
                    followersCount: jsonUser.followerCount,
                    followingCount: jsonUser.followingCount,
                    profileImage: jsonUser.pictures.large)
    }
    
    func makeFollowingList(from jsonFollowing: JsonFollowing) -> [String] {
        return jsonFollowing.users.map { $0.username }
    }
}

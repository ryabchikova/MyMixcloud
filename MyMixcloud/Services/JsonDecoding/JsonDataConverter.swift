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
                    profileImage: jsonUser.pictures.large,
                    coverImage: jsonUser.coverPictures.small)
    }
    
    func makeFollowingList(from jsonFollowing: JsonFollowing) -> [String] {
        return jsonFollowing.users.map { $0.username }
    }
    
    func makeTag(from jsonTag: JsonTag) -> Tag {
        return Tag(identifier: jsonTag.key, name: jsonTag.name)
    }
    
    func makeTrack(from jsonTrack: JsonTrack) -> Track {
        return Track(identifier: jsonTrack.key,
                     title: jsonTrack.name,
                     coverImage: jsonTrack.pictures.large,
                     user: (identifier: jsonTrack.user.username, name: jsonTrack.user.name),
                     tags: jsonTrack.tags.map { makeTag(from: $0) },
                     playCount: jsonTrack.playCount,
                     createdTime: jsonTrack.createdTime,       // TODO format
                     listenTime: jsonTrack.listenTime,         // TODO format
                     audioLength: jsonTrack.audioLength.description,       // TODO format in human readable time string
                     favoriteCount: jsonTrack.favoriteCount,
                     listenerCount: jsonTrack.listenerCount,
                     repostCount: jsonTrack.repostCount)
    }
    
    func makeTrackList(from jsonTrackList: JsonTrackList) -> [Track] {
        return jsonTrackList.tracks.map { makeTrack(from: $0) }
    }
}

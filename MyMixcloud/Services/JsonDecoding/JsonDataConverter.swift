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
                    coverImage: jsonUser.coverPictures?.small)
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
                     uploadedTime: convertTimestamp(jsonTrack.createdTime),
                     listenTime: jsonTrack.listenTime.map { convertTimestamp($0) } ?? nil,
                     audioLength: convertSecondsToReadableTime(jsonTrack.audioLength),
                     favoriteCount: jsonTrack.favoriteCount,
                     listenerCount: jsonTrack.listenerCount,
                     repostCount: jsonTrack.repostCount)
    }
    
    func makeTrackList(from jsonTrackList: JsonTrackList) -> [Track] {
        return jsonTrackList.tracks.map { makeTrack(from: $0) }
    }
}

extension JsonDataConverter {

    private func convertTimestamp(_ input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM HH:mm"
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return inputFormatter.date(from: input).map { outputFormatter.string(from: $0) }
    }
    
    private func convertSecondsToReadableTime(_ input: Int) -> String? {
        guard input > 0 && input < 24*60*60 else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm:ss"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return outputFormatter.string(from: Date(timeIntervalSince1970: Double(input)))
    }
}

//
//  JsonConversions.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 31.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

extension JsonTag: BusinessModelConvertible {
    var businessModel: Tag {
        Tag(identifier: key, name: name)
    }
}

extension JsonTrack: BusinessModelConvertible {
    var businessModel: Track {
        Track(identifier: key,
              title: name,
              coverImage: pictures.large,
              user: (identifier: user.username, name: user.name),
              tags: tags.map { $0.businessModel },
              playCount: playCount,
              uploadedTime: JsonDataConverter.convertTimestamp(createdTime),
              listenTime: listenTime.map { JsonDataConverter.convertTimestamp($0) } ?? nil,
              audioLength: JsonDataConverter.convertSecondsToReadableTime(audioLength),
              favoriteCount: favoriteCount,
              listenerCount: listenerCount,
              repostCount: repostCount)
    }
}

extension JsonTrackList: BusinessModelConvertible {
    var businessModel: [Track] {
        tracks.map { $0.businessModel }
    }
}

extension JsonUser: BusinessModelConvertible {
    var businessModel: User {
        User(identifier: username,
             name: name,
             country: country,
             city: city,
             bio: biog,
             favoritesCount: favoriteCount,
             followersCount: followerCount,
             followingCount: followingCount,
             cloudcastsCount: cloudcastCount,
             profileImage: pictures.large,
             coverImage: coverPictures?.small)
    }
}

extension JsonFollowing: BusinessModelConvertible {
    var businessModel: [String] {
        users.map { $0.username }
    }
}

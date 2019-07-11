//
//  TrackViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

struct TrackViewModel {
    let trackId: String
    let trackTitleString: NSAttributedString
    let coverImageUrl: URL?
    let userNameString: NSAttributedString
    let audioLengthString: NSAttributedString?
    let uploadedTimeString: NSAttributedString?
    let favoritedString: NSAttributedString?
    let listenedString: NSAttributedString?
    let repostedString: NSAttributedString?
    let tags: [NSAttributedString]?
    
    init(track: Track) {
        trackId = track.identifier
        trackTitleString = NSAttributedString(string: track.title, attributes: Styles.title)
        coverImageUrl = track.coverImage
        userNameString = NSAttributedString(string: "by " + track.user.name, attributes: Styles.name)
        audioLengthString = track.audioLength.map { NSAttributedString(string: $0, attributes: Styles.time) }
        uploadedTimeString = track.uploadedTime.map { NSAttributedString(string: "Uploaded " + $0, attributes: Styles.time) }
        favoritedString = track.favoriteCount > 0 ? NSAttributedString(string: track.favoriteCount.description, attributes: Styles.counter) : nil
        listenedString = track.listenerCount > 0 ? NSAttributedString(string: track.listenerCount.description, attributes: Styles.counter) : nil
        repostedString = track.repostCount > 0 ? NSAttributedString(string: track.repostCount.description, attributes: Styles.counter) : nil
        tags = track.tags.isEmpty ? nil : track.tags.map { NSAttributedString(string: "#" + $0.name, attributes: Styles.tag) }
    }
}

extension TrackViewModel {
    
    private struct Styles {
        
        static let title: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.largeBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let name: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.medium,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let time: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.small,
                .foregroundColor: MMColors.lightGray
            ]
        }()
        
        static let counter: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBold,
                .foregroundColor: MMColors.blue
            ]
        }()
        
        static let tag: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBoldItalic,
                .foregroundColor: MMColors.sunny
            ]
        }()
    }
}

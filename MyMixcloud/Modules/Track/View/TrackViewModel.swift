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
        audioLengthString = track.audioLength.map { NSAttributedString(string: $0, attributes: Styles.temp) }
        uploadedTimeString = track.uploadedTime.map { NSAttributedString(string: "Uploaded " + $0, attributes: Styles.temp) }
        favoritedString = track.favoriteCount > 0 ? NSAttributedString(string: "Favorited " + track.favoriteCount.description, attributes: Styles.temp) : nil
        listenedString = track.listenerCount > 0 ? NSAttributedString(string: "Listened " + track.listenerCount.description, attributes: Styles.temp) : nil
        repostedString = track.repostCount > 0 ? NSAttributedString(string: "Reposted " + track.repostCount.description, attributes: Styles.temp) : nil
        tags = nil      // TODO
    }
}

extension TrackViewModel {
    
    private struct Styles {
        
        static let title: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            return [
                .paragraphStyle: style,
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let name: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.medium,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        // TODO
        static let temp: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.blue
            ]
        }()
    }
}

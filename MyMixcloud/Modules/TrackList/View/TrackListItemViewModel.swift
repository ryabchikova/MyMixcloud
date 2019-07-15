//
//  TrackListItemViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

struct TrackListItemViewModel: Identifiable {
    
    let identifier: String
    let coverImageUrl: URL?
    let userNameString: NSAttributedString
    let trackTitleString: NSAttributedString
    let audioLengthString: NSAttributedString?
    
    init(track: Track) {
        identifier = track.identifier
        coverImageUrl = track.coverImage
        userNameString = NSAttributedString(string: "by " + track.user.name, attributes: Styles.name)
        trackTitleString = NSAttributedString(string: track.title, attributes: Styles.title)
        audioLengthString = track.audioLength.map { NSAttributedString(string: $0, attributes: Styles.length) }
    }
}

extension TrackListItemViewModel {
    
    private struct Styles {
        
        static let name: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.medium,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let title: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            return [
                .paragraphStyle: style,
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let length: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBold,
                .foregroundColor: MMColors.blue
            ]
        }()
    }
}

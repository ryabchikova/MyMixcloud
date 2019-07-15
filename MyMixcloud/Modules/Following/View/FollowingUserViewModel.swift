//
//  FollowingUserViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

struct FollowingUserViewModel: Identifiable {
    let identifier: String
    let avatarImageUrl: URL?
    let nameString: NSAttributedString
    let locationString: NSAttributedString?
    let followersString: NSAttributedString?
    
    init(user: User) {
        identifier = user.identifier
        avatarImageUrl = user.profileImage
        nameString = NSAttributedString(string: user.name, attributes: Styles.name)
        
        var location = user.city ?? ""
        if let country = user.country {
            location.append(location.isEmpty ? country : ", \(country)")
        }
        locationString = location.isEmpty ? nil : NSAttributedString(string: location, attributes: Styles.location)
        
        if user.followersCount > 0 {
            let followers = user.followersCount.description + " Followers"
            followersString = NSAttributedString(string: followers, attributes: Styles.followers)
        } else {
            followersString = nil
        }
    }
}

extension FollowingUserViewModel {
    
    private struct Styles {
        static let name: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            return [
                .paragraphStyle: style,
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let location: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            return [
                .paragraphStyle: style,
                .font: MMFonts.medium,
                .foregroundColor: MMColors.lightGray
            ]
        }()
        
        static let followers: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            return [
                .paragraphStyle: style,
                .font: MMFonts.medium,
                .foregroundColor: MMColors.lightGray
            ]
        }()
    }
}


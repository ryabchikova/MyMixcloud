//
//  UserProfileViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct UserProfileViewModel {
    
    let avatarImageUrl: URL?
    let coverImageUrl: URL?
    let nameString: NSAttributedString
    let locationString: NSAttributedString?
    let bioString: NSAttributedString?
    let followersString: NSAttributedString?
    
    init(user: User) {
        avatarImageUrl = user.profileImage
        coverImageUrl = user.coverImage
        nameString = NSAttributedString(string: user.name, attributes: Styles.name)
        
        var location = user.city ?? ""
        if let country = user.country {
            location.append(location.isEmpty ? country : ", \(country)")
        }
        locationString = location.isEmpty ? nil : NSAttributedString(string: location, attributes: Styles.location)
        
        bioString = user.bio.map { NSAttributedString(string: $0, attributes: Styles.bio) }
        
        if user.followersCount > 0 {
            let followers = user.followersCount.description + " Followers"
            followersString = NSAttributedString(string: followers, attributes: Styles.followers)
        } else {
            followersString = nil
        }
    }
}

extension UserProfileViewModel {
    
    private struct Styles {
        static let name: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.largeBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let location: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let bio: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBoldItalic,
                .foregroundColor: MMColors.lightGray
            ]
        }()
        
        static let followers: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBold,
                .foregroundColor: MMColors.blue
            ]
        }()
    }
}

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
    let followingString: NSAttributedString?
    let cloudcastsString: NSAttributedString?
    
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
        
        followersString = user.followersCount > 0 ? NSAttributedString(string: "Followers " + user.followersCount.description, attributes: Styles.counters) : nil
        followingString = user.followingCount > 0 ? NSAttributedString(string: "Follow " + user.followingCount.description, attributes: Styles.counters) : nil
        cloudcastsString = user.cloudcastsCount > 0 ? NSAttributedString(string: "Shows " + user.cloudcastsCount.description, attributes: Styles.counters) : nil
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
        
        static let counters: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.smallBold,
                .foregroundColor: MMColors.blue
            ]
        }()
    }
}

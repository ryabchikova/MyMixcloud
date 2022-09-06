//
//  SettingsViewModel.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

enum SettingsViewModel: String {
    case logout
    case theme
}

extension SettingsViewModel: Identifiable {
    var identifier: String {
        rawValue
    }
}

extension SettingsViewModel {
    
    var title: NSAttributedString {
        let attributes = isEnabled ? Styles.title : Styles.titleDisabled
        switch self {
        case .logout:
            return NSAttributedString(string: "Log out", attributes: attributes)
        case .theme:
            return NSAttributedString(string: "Theme", attributes: attributes)
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .logout:
            return true
        case .theme:
            return false
        }
    }

}
    
private extension SettingsViewModel {
    struct Styles {
        static let title: [NSAttributedString.Key: Any] = [
            .font: MMFonts.mediumBold,
            .foregroundColor: MMColors.darkGray
        ]
        
        static let titleDisabled: [NSAttributedString.Key : Any] = [
            .font: MMFonts.medium,
            .foregroundColor: MMColors.lightGray
        ]
    }
}

//
//  SettingsViewModel.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation


struct SettingsViewModel {
    let shouldShowAccessoryView: Bool
    let isSwitcherOn: Bool
    let onSwitch: ((Bool) -> Void)?
    
    private let option: SettingsOption
    
    init(_ option: SettingsOption, onSwitch: ((Bool) -> Void)? = nil) {
        self.option = option
        if case let .cashing(isOn) = option {
            shouldShowAccessoryView = true
            isSwitcherOn = isOn
        } else {
            shouldShowAccessoryView = false
            isSwitcherOn = false
        }
        self.onSwitch = onSwitch
    }
    
    var isEnabled: Bool {
        option != .theme
    }

    var title: NSAttributedString {
        let attributes = isEnabled ? Styles.title : Styles.titleDisabled
        switch option {
        case .logout:
            return NSAttributedString(string: "Log out", attributes: attributes)
        case .cashing:
            return NSAttributedString(string: "Cache usage", attributes: attributes)
        case .theme:
            return NSAttributedString(string: "Theme", attributes: attributes)
        }
    }
}

extension SettingsViewModel: Identifiable {
    var id: SettingsOption { option }
}
    
private extension SettingsViewModel {
    enum Styles {
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

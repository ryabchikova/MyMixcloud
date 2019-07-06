//
//  LoginViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

struct LoginViewModel {
    
    let welcomeString: NSAttributedString
    let userNamePlaceholderString: NSAttributedString
    let userNameStringFont: UIFont
    let userNameStringColor: UIColor
    let startButtonEnabledString: NSAttributedString
    let startButtonDisabledString: NSAttributedString
    
    init() {
        welcomeString = NSAttributedString(string: "Hi, to start\nenter your username ", attributes: Styles.welcome)
        userNamePlaceholderString = NSAttributedString(string: "Username", attributes: Styles.placeholder)
        userNameStringFont = Styles.userName[.font] as! UIFont
        userNameStringColor = Styles.userName[.foregroundColor] as! UIColor
        startButtonEnabledString = NSAttributedString(string: "Let's go!", attributes: Styles.startButtonEnabled)
        startButtonDisabledString = NSAttributedString(string: "Let's go!", attributes: Styles.startButtonDisabled)
    }
}

extension LoginViewModel {
    
    private struct Styles {
        static let welcome: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.largeBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let placeholder: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.medium,
                .foregroundColor: MMColors.lightGray
            ]
        }()
        
        static let userName: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let startButtonEnabled: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let startButtonDisabled: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.lightGray
            ]
        }()
    }
}

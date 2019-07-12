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
    let startButtonEnabledString: NSAttributedString
    let startButtonDisabledString: NSAttributedString
    
    init() {
        welcomeString = NSAttributedString(string: "Hi! To start\nenter your username", attributes: Styles.welcome)
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

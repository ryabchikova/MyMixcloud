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
    enum ButtonState {
        case normal, disabled, highlited
    }
    
    let welcomeString = NSAttributedString(string: "Hi! To start\nenter your username",
                                           attributes: Styles.welcome)
    
    func startButtonString(for state: ButtonState) -> NSAttributedString {
        NSAttributedString(string: "Let's go!", attributes: Styles.startButton(for: state))
    }
    
    var onButtonTap: ((String) -> Void)?
}

private extension LoginViewModel {
     enum Styles {
        static let welcome: [NSAttributedString.Key: Any] = [
            .font: MMFonts.largeBold,
            .foregroundColor: MMColors.darkGray
        ]
        
        static func startButton(for state: ButtonState) -> [NSAttributedString.Key: Any] {
            [
                .font: MMFonts.mediumBold,
                .foregroundColor: state == .normal ? MMColors.darkGray : MMColors.lightGray
            ]
        }
    }
}

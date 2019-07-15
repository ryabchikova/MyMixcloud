//
//  DummyViewModel.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

struct DummyViewModel {
    
    let errorMessageString: NSAttributedString
    let retryButtonTitleString: NSAttributedString
    
    init(error: MMError) {
        if case .networkUnreachable = error.type {
            errorMessageString = NSAttributedString(string: "No internet connection. Check your network settings.", attributes: Styles.message)
        } else {
            errorMessageString = NSAttributedString(string: "An error has occurred.", attributes: Styles.message)
        }
        retryButtonTitleString = NSAttributedString(string: "Try again", attributes: Styles.button)
    }
}

extension DummyViewModel {
    
    private struct Styles {
        static let message: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
        
        static let button: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
    }
}

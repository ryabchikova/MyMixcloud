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
    
    enum ButtonState {
        case normal, highlited
    }
    
    let errorMessageString: NSAttributedString
    
    init(error: MMError) {
        if case .networkUnreachable = error.type {
            errorMessageString = NSAttributedString(string: "No internet connection. Check your network settings.", attributes: Styles.message)
        } else {
            errorMessageString = NSAttributedString(string: "An error has occurred.", attributes: Styles.message)
        }
    }
    
    func retryButtonString(for state: ButtonState) -> NSAttributedString {
        return NSAttributedString(string: "Try again", attributes: Styles.retryButton(for: state))
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
        
        static func retryButton(for state: ButtonState) -> [NSAttributedString.Key: Any] {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: state == .normal ? MMColors.darkGray : MMColors.lightGray
            ]
        }
    }
}

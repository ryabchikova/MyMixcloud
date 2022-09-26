//
//  MMColors.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

fileprivate let rgb: (Int, Int, Int, CGFloat) -> UIColor = {
    return UIColor(red: CGFloat($0)/255.0, green: CGFloat($1)/255.0, blue: CGFloat($2)/255.0, alpha: $3)
}

fileprivate let whiteTint: (Int, CGFloat) -> UIColor = {
    return rgb($0, $0, $0, $1)
}

fileprivate let rgbOpaque: (Int, Int, Int) -> UIColor = {
    return UIColor(red: CGFloat($0)/255.0, green: CGFloat($1)/255.0, blue: CGFloat($2)/255.0, alpha: 1.0)
}

enum MMColors {
    // colors
    static let white = whiteTint(255, 1.0)
    
    static let darkGray = rgb(61, 65, 80, 0.7)
    static let lightGray = whiteTint(160, 0.9)
    static let superLightGray = whiteTint(235, 1.0)
    
    static let blue = rgbOpaque(101, 176, 217)
    
    static let sunny = rgbOpaque(255, 166, 11)
    static let weakSunny = rgb(255, 166, 11, 0.4)
    
    // entities
    static let imagePlaceholder = whiteTint(235, 1.0)
    
}

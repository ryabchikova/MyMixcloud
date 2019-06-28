//
//  Fonts.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

enum MMFonts {

    private enum Size: CGFloat {
        case small = 12.0
        case medium = 16.0
        case large = 20.0
    }

    static let small = UIFont.init(name: "CourierNewPSMT", size: Size.small.rawValue)!
    static let medium = UIFont.init(name: "CourierNewPSMT", size: Size.medium.rawValue)!
    static let large = UIFont.init(name: "CourierNewPSMT", size: Size.large.rawValue)!

    static let smallItalic = UIFont.init(name: "CourierNewPS-ItalicMT", size: Size.small.rawValue)!
    static let mediumItalic = UIFont.init(name: "CourierNewPS-ItalicMT", size: Size.medium.rawValue)!
    static let largeItalic = UIFont.init(name: "CourierNewPS-ItalicMT", size: Size.large.rawValue)!

    static let smallBold = UIFont.init(name: "CourierNewPS-BoldMT", size: Size.small.rawValue)!
    static let mediumBold = UIFont.init(name: "CourierNewPS-BoldMT", size: Size.medium.rawValue)!
    static let largeBold = UIFont.init(name: "CourierNewPS-BoldMT", size: Size.large.rawValue)!

    static let smallBoldItalic = UIFont.init(name: "CourierNewPS-BoldItalicMT", size: Size.small.rawValue)!
    static let mediumBoldItalic = UIFont.init(name: "CourierNewPS-BoldItalicMT", size: Size.medium.rawValue)!
    static let largeBoldItalic = UIFont.init(name: "CourierNewPS-BoldItalicMT", size: Size.large.rawValue)!
}

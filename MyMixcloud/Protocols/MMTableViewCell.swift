//
//  MMTableViewCell.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import CoreGraphics


protocol MMTableViewCell {
    associatedtype T
    
    static var height: CGFloat { get }
    func update(with model: T)
}

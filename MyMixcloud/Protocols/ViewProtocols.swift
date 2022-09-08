//
//  ViewProtocols.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import CoreGraphics

protocol ConfigurableView: AnyObject {
    associatedtype Model

    func configure(with model: Model)
}

protocol FixedHeightView: AnyObject {
    static var height: CGFloat { get }
}

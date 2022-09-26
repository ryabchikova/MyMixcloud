//
//  String+Extensions.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 29.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

extension String {
    
    static func callLocation<T>(_ caller: T, context: String) -> String {
        String(describing: caller) + ".\(context)"
    }

}


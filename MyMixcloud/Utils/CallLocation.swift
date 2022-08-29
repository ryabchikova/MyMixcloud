//
//  CallLocation.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 29.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

// TODO: подумать над неймингом
protocol CallLocation {
    func location(caller: String) -> String
}

extension CallLocation {
    func location(caller: String) -> String {
        String(describing: self) + ".\(caller)"
    }
}

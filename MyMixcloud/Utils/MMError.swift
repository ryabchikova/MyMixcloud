//
//  MixcloudError.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 19/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

enum MMError: Error {
    case serverError(description: String)
    case executionError(description: String)
}

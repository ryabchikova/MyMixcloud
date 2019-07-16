//
//  LoadingOptions.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 16/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

enum LoadingReason {
    case regular
    case pullToRefresh
}

enum LoadingSource {
    case web
    case cache
}

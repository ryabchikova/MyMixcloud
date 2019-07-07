//
//  SettingsService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 05/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol SettingsService {
    func currentUserId() -> String?
    func setCurrentUserId(_ userId: String)
    func removeCurrentUserId()
}

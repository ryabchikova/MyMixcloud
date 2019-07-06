//
//  SettingsServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 05/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class SettingsServiceImpl: SettingsService {
    
    private let userDefaults = UserDefaults.standard
    
    private enum UserDefaultsKey: String {
        case curentUserId
    }
    
    func curentUserId() -> String? {
        return userDefaults.string(forKey: UserDefaultsKey.curentUserId.rawValue)
    }
    
    func setCurentUserId(_ userId: String) {
        userDefaults.set(userId, forKey: UserDefaultsKey.curentUserId.rawValue)
    }
}

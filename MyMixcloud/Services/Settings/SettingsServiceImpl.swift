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

    // MARK: - User
    
    func currentUserId() -> String? {
        return userDefaults.string(forKey: UserDefaultsKey.currentUserId)
    }
    
    func setCurrentUserId(_ userId: String) {
        userDefaults.set(userId, forKey: UserDefaultsKey.currentUserId)
    }
    
    func removeCurrentUserId() {
        userDefaults.removeObject(forKey: UserDefaultsKey.currentUserId)
    }
    
    func isLoggedIn() -> Bool {
        return currentUserId() != nil
    }
    
    // MARK: - Cache usage
    
    func isCacheUsageEnabled() -> Bool {
        guard let value = userDefaults.object(forKey: UserDefaultsKey.cacheUsage) else {
            return true
        }
        
        return value as! Bool
    }
    
    func setCacheUsageEnabled(_ isEnabled: Bool) {
        userDefaults.set(isEnabled, forKey: UserDefaultsKey.cacheUsage)
    }
}

private extension SettingsServiceImpl {
    enum UserDefaultsKey {
        static let currentUserId = "currentUserId"
        static let cacheUsage = "cacheUsage"
    }
}

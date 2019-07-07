//
//  AppRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 07/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class AppRouter {
    private(set) var rootViewController: UIViewController? {
        didSet {
            UIApplication.shared.delegate?.window??.rootViewController = rootViewController
        }
    }
    private let settingsService: SettingsService
    
    init(settingsService: SettingsService) {
        self.settingsService = settingsService
        
        if let currentUserId = settingsService.currentUserId() {
            rootViewController = MainTabBarViewController(currentUserId: currentUserId)
        } else {
            let loginContainer = LoginContainer.assemble(with: LoginContext(moduleOutput: self))
            rootViewController = loginContainer.viewController
        }
    }
    
    
}

extension AppRouter: LoginModuleOutput {
    func didFinish() {
        guard let currentUserId = settingsService.currentUserId() else {
            fatalError("Application error: can't receive curent user id")
        }
        // TODO тут нужна с анимация или еще что-то для корректной подмены рутового вью-контролеера ???
        rootViewController = MainTabBarViewController(currentUserId: currentUserId)
    }
}

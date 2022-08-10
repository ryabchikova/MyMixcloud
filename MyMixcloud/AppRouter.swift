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
        
        if settingsService.isLoggedIn() {
            showMainScreen()
        } else {
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        rootViewController = LoginModuleBuilder.build(moduleOutput: self).viewController
    }
    
    private func showMainScreen() {
        guard let currentUserId = settingsService.currentUserId() else {
            fatalError("Application error: can't receive curent user id")
        }
        let context = MainContext(currentUserId: currentUserId)
        rootViewController = MainModuleBuilder.build(context).viewController
    }
}

extension AppRouter: LoginModuleOutput {
    func didLogin() {
        showMainScreen()
    }
}

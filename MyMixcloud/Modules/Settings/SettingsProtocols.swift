//
//  SettingsProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


import UIKit

// MARK: - Module
protocol SettingsModuleInput: AnyObject {}

protocol SettingsModuleOutput: AnyObject {}

// MARK: - View
protocol SettingsViewInput: AnyObject {
    func set(viewModels: [SettingsViewModel])
}

protocol SettingsViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectOption(_ option: SettingsOption)
}

// MARK: - Interactor
protocol SettingsInteractorInput {
    func logout()
    func isCacheUsageEnabled() -> Bool
    func setCacheUsageEnabled(_ isEnabled: Bool)
}

protocol SettingsInteractorOutput: AnyObject {
    func didLogout()
}

// MARK: - Router
protocol SettingsRouterInput {
    func showLoginScreen()
    func showLogoutAlert(in viewController: UIViewController,
                         logoutCompletion: @escaping (UIAlertAction) -> Void)
}

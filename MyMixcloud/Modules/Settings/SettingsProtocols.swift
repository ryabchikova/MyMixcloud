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
protocol SettingsViewInput: AnyObject {}

protocol SettingsViewOutput: AnyObject {
    func didSelectItem(_ item: SettingsItem)
}

// MARK: - Interactor
protocol SettingsInteractorInput {
    func logout()
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

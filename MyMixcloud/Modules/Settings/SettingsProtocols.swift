//
//  SettingsProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsModuleInput {
    var moduleOutput: SettingsModuleOutput? { get }
}

protocol SettingsModuleOutput: class {
}

protocol SettingsViewInput: class {
}

protocol SettingsViewOutput: class {
    func didSelectItem(_ item: SettingsItem)
}

protocol SettingsInteractorInput: class {
    func logout()
}

protocol SettingsInteractorOutput: class {
    func didLogout()
}

protocol SettingsRouterInput: class {
    func showLoginScreen()
    func showLogoutAlert(in viewController: UIViewController, logoutCompletion: @escaping (UIAlertAction) -> Void)
}

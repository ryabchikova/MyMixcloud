//
//  SettingsRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsRouter {
    weak var applicationRouter: AppRouter?
}

extension SettingsRouter: SettingsRouterInput {
    func showLoginScreen() {
        applicationRouter?.showLoginScreen()
    }
    
    func showLogoutAlert(in viewController: UIViewController, logoutCompletion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: nil,
                                                message: "Do you want to log out?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: logoutCompletion))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

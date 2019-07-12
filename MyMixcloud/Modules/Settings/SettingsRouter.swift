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
}

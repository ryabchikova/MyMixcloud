//
//  UserProfileRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class UserProfileRouter {
}

extension UserProfileRouter: UserProfileRouterInput {
    func showSettingsScreen(in navigationController: UINavigationController, moduleOutput: SettingsModuleOutput?) {
        let settingsContainer = SettingsContainer.assemble(with: SettingsContext(moduleOutput: moduleOutput))
        navigationController.pushViewController(settingsContainer.viewController, animated: true)
    }
}

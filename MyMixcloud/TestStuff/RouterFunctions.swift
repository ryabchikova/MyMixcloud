//
//  RouterFunctions.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 19.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

final class RouterFunctions {

    private init() {}

    static func showErrorAlert(from viewController: UIViewController) {
        let alertController = UIAlertController(title: "Login error",
                                                message: "User not found. Create account on www.mixcloud.com to use this App.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func showLogoutAlert(from viewController: UIViewController,
                                logoutCompletion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: nil,
                                                message: "Do you want to log out?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: logoutCompletion))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func showSettingsScreen(from viewController: UIViewController) {
        let module = SettingsModuleBuilder.build(moduleOutput: InjectionManager.shared.appRouter())
        viewController.show(module.viewController, sender: nil)
    }

    static func showUserProfileScreen(from viewController: UIViewController,
                               userId: String,
                               isMyProfile: Bool) {
        let context = UserProfileContext(userId: userId, isMyProfile: isMyProfile)
        let module = UserProfileModuleBuilder.build(context)
        viewController.show(module.viewController, sender: nil)
    }

    static func showTrackScreen(from viewController: UIViewController, trackId: String) {
        let context = TrackContext(trackId: trackId)
        let module = TrackModuleBuilder.build(context)
        viewController.show(module.viewController, sender: nil)
    }
}

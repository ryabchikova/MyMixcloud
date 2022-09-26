//
//  GRouter.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 18.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

/// Describe interface for routing in application,
/// except routing associated with Application's rootViewController
protocol RoutingTrait: BaseRouter {
    func showAlert(model: AlertViewModel)
    func showSettingsScreen()
    func showUserProfileScreen(userId: String, isMyProfile: Bool)
    func showTrackScreen(trackId: String)
}

extension RoutingTrait {
    func showAlert(model: AlertViewModel) {
        let alertController = UIAlertController(title: model.title,
                                                message: model.message,
                                                preferredStyle: .alert)
        model.actions.forEach { alertController.addAction($0) }
        viewController.present(alertController, animated: true, completion: nil)
    }

    func showSettingsScreen() {
        let module = SettingsModuleBuilder.build(moduleOutput: InjectionManager.shared.appRouter())
        viewController.show(module.viewController, sender: nil)
    }

    func showUserProfileScreen(userId: String, isMyProfile: Bool) {
        let context = UserProfileContext(userId: userId, isMyProfile: isMyProfile)
        let module = UserProfileModuleBuilder.build(context)
        viewController.show(module.viewController, sender: nil)
    }
    
    func showTrackScreen(trackId: String) {
        let context = TrackContext(trackId: trackId)
        let module = TrackModuleBuilder.build(context)
        viewController.show(module.viewController, sender: nil)
    }
}


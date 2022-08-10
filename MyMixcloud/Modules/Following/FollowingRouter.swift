//
//  FollowingRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class FollowingRouter {}

extension FollowingRouter: FollowingRouterInput {
    func showUserProfileScreen(in viewController: UIViewController, userId: String) {
        let context = UserProfileContext(userId: userId, isMyProfile: false)
        let module = UserProfileModuleBuilder.build(context)
        viewController.show(module.viewController, sender: self)
    }
}

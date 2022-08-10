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
        let userContainer = UserProfileModuleBuilder.build(
            with: UserProfileContext(userId: userId, isMyProfile: false)
        )
        viewController.show(userContainer.viewController, sender: self)
    }
}

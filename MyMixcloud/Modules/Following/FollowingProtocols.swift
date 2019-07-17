//
//  FollowingProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol FollowingModuleInput {
	var moduleOutput: FollowingModuleOutput? { get }
}

protocol FollowingModuleOutput: class {
}

protocol FollowingViewInput: class {
    var isEmpty: Bool { get }
    func set(viewModels: [FollowingUserViewModel])
    func reset(viewModels: [FollowingUserViewModel])
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
    func showActivity()
    func hideActivity()
}

protocol FollowingViewOutput: class {
    func viewWillAppear()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnUser(with userId: String)
}

protocol FollowingInteractorInput: class {
    func loadFollowing(userId: String, page: Int, reason: LoadingReason, useCache permit: Bool)
}

protocol FollowingInteractorOutput: class {
    func gotError(_ error: MMError)
    func didLoadFollowing(_ users: [User], reason: LoadingReason)
}

protocol FollowingRouterInput: class {
    func showUserProfileScreen(in viewController: UIViewController, userId: String)
}


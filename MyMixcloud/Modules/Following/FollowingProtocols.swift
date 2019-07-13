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
    func set(viewModels: [FollowingUserViewModel])
    func reset(viewModels: [FollowingUserViewModel])
    func showDummyView()
}

protocol FollowingViewOutput: class {
    func viewDidLoad()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnUser(with userId: String)
}

protocol FollowingInteractorInput: class {
    func loadFollowing(userId: String, page: Int, reason: LoadingReason)
}

protocol FollowingInteractorOutput: class {
    func gotError()
    func didLoadFollowing(_ users: [User], reason: LoadingReason)
}

protocol FollowingRouterInput: class {
    func showUserProfileScreen(in viewController: UIViewController, userId: String)
}


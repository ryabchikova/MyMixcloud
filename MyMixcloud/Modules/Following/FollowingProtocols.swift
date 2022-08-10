//
//  FollowingProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

// MARK: - Module
protocol FollowingModuleInput: AnyObject {}

protocol FollowingModuleOutput: AnyObject {}

// MARK: - View
protocol FollowingViewInput: AnyObject {
    var isEmpty: Bool { get }
    func set(viewModels: [FollowingUserViewModel])
    func reset(viewModels: [FollowingUserViewModel])
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
}

protocol FollowingViewOutput: AnyObject {
    func viewWillAppear()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnUser(with userId: String)
}

// MARK: - Interactor
protocol FollowingInteractorInput {
    func loadFollowing(userId: String, page: Int, reason: LoadingReason, useCache permit: Bool)
}

protocol FollowingInteractorOutput: AnyObject {
    func gotError(_ error: MMError)
    func didLoadFollowing(_ users: [User], reason: LoadingReason)
}

// MARK: - Router
protocol FollowingRouterInput {
    func showUserProfileScreen(in viewController: UIViewController, userId: String)
}


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
protocol FollowingViewInput: DummyViewDisplayable, EmptyCheckTrait {
    func set(viewModels: [FollowingUserViewModel])
    func reset(viewModels: [FollowingUserViewModel])
}

protocol FollowingViewOutput: AnyObject {
    func viewWillAppear()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnUser(with userId: String)
}

// MARK: - Interactor
protocol FollowingInteractorInput {
    func loadFollowing(userId: String, page: Int, reason: LoadingReason)
}

protocol FollowingInteractorOutput: AnyObject {
    func gotError(_ error: MMError) async
    func didLoadFollowing(_ users: [User], reason: LoadingReason) async
}

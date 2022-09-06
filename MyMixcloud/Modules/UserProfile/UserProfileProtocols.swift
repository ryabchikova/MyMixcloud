//
//  UserProfileProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

// MARK: - Module
protocol UserProfileModuleInput: AnyObject {}

protocol UserProfileModuleOutput: AnyObject {}

// MARK: - View
protocol UserProfileViewInput: AnyObject {
    var isEmpty: Bool { get }
    func set(userProfileViewModel: UserProfileViewModel)
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
    func showActivity()
    func hideActivity()
}

protocol UserProfileViewOutput {
    func viewWillAppear()
    func didPullToRefresh()
    func didTapSettingsButton()
}

// MARK: - Interactor
protocol UserProfileInteractorInput {
    func loadUser(userId: String)
}

protocol UserProfileInteractorOutput: AnyObject {
    func gotError(_ error: MMError) async
    func didLoadUser(_ user: User) async
}

// MARK: - Router
protocol UserProfileRouterInput {
    func showSettingsScreen(in viewController: UIViewController)
}

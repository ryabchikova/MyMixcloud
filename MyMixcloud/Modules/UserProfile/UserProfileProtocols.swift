//
//  UserProfileProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol UserProfileModuleInput {
	var moduleOutput: UserProfileModuleOutput? { get }
}

protocol UserProfileModuleOutput: class {
}

protocol UserProfileViewInput: class {
    var isEmpty: Bool { get }
    func set(userProfileViewModel: UserProfileViewModel)
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
}

protocol UserProfileViewOutput: class {
    func viewWillAppear()
    func didPullToRefresh()
    func didTapSettingsButton()
}

protocol UserProfileInteractorInput: class {
    func loadUser(userId: String)
}

protocol UserProfileInteractorOutput: class {
    func gotError(_ error: MMError)
    func didLoadUser(_ user: User)
}

protocol UserProfileRouterInput: class {
    func showSettingsScreen(in viewController: UIViewController)
}

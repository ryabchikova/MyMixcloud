//
//  MainContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class MainContainer {
    let input: MainModuleInput
	let viewController: UIViewController

	class func assemble(with context: MainContext) -> MainContainer {
        let presenter = MainPresenter()
        let viewController = MainViewController(output: presenter)
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

        // configure tabs
        let profileContext = UserProfileContext(moduleOutput: presenter, userId: context.currentUserId, isMyProfile: true)
        let profileContainer = UserProfileContainer.assemble(with: profileContext)
        profileContainer.viewController.tabBarItem.image = UIImage(named: "profileIcon")

        let followingContext = FollowingContext(moduleOutput: nil, userId: context.currentUserId)
        let followingContainer = FollowingContainer.assemble(with: followingContext)
        followingContainer.viewController.tabBarItem.image = UIImage(named: "followingIcon")
        
        let historyContext = TrackListContext(moduleOutput: nil, userId: context.currentUserId, trackListType: .history)
        let historyContainer = TrackListContainer.assemble(with: historyContext)
        historyContainer.viewController.tabBarItem.image = UIImage(named: "historyIcon")
        
        let favoriteContext = TrackListContext(moduleOutput: nil, userId: context.currentUserId, trackListType: .favorite)
        let favoriteContainer = TrackListContainer.assemble(with: favoriteContext)
        favoriteContainer.viewController.tabBarItem.image = UIImage(named: "favoriteIcon")
        
        viewController.configureTabs(сontrollers: [profileContainer.viewController,
                                                   followingContainer.viewController,
                                                   historyContainer.viewController,
                                                   favoriteContainer.viewController])

        return MainContainer(view: viewController, input: presenter)
	}

    private init(view: UIViewController, input: MainModuleInput) {
		self.viewController = view
        self.input = input
	}
}

struct MainContext {
	weak var moduleOutput: MainModuleOutput?
    let currentUserId: String
}

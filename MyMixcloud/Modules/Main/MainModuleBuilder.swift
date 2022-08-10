//
//  MainModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit


struct MainModuleBuilder {

    private init() {}

	static func build(_ context: MainContext,
                      moduleOutput: MainModuleOutput? = nil) -> Module<MainModuleInput> {
        let presenter = MainPresenter(moduleOutput: moduleOutput)
        let viewController = MainViewController(output: presenter)
		presenter.view = viewController

        // configure tabs
        let profileContext = UserProfileContext(userId: context.currentUserId, isMyProfile: true)
        let profileViewController = UserProfileModuleBuilder.build(profileContext).viewController
        profileViewController.tabBarItem.image = UIImage(named: "profileIcon")
        
        let followingContext = FollowingContext(userId: context.currentUserId)
        let followingViewController = FollowingModuleBuilder.build(followingContext).viewController
        followingViewController.tabBarItem.image = UIImage(named: "followingIcon")
        
        let historyContext = TrackListContext(userId: context.currentUserId, trackListType: .history)
        let historyViewController = TrackListModuleBuilder.build(historyContext).viewController
        historyViewController.tabBarItem.image = UIImage(named: "historyIcon")
        
        let favoriteContext = TrackListContext(userId: context.currentUserId, trackListType: .favorite)
        let favoriteViewController = TrackListModuleBuilder.build(favoriteContext).viewController
        favoriteViewController.tabBarItem.image = UIImage(named: "favoriteIcon")
        
        viewController.configureTabs(сontrollers: [historyViewController,
                                                   followingViewController,
                                                   favoriteViewController,
                                                   profileViewController])

        return Module(viewController, presenter)
	}

}

struct MainContext {
    let currentUserId: String
}

//
//  MainTabBarViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    private let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
        let profileContext = UserProfileContext(moduleOutput: nil, userId: self.currentUserId)
        let profileContainer = UserProfileContainer.assemble(with: profileContext)
        profileContainer.viewController.tabBarItem.image = UIImage(named: "profileIcon")
        
        let followingContainer = FollowingContainer.assemble(with: FollowingContext(moduleOutput: nil,
                                                                                    userId: self.currentUserId))
        followingContainer.viewController.tabBarItem.image = UIImage(named: "followingIcon")
        
        let historyContainer = TrackListContainer.assemble(with: TrackListContext(moduleOutput: nil,
                                                                                  userId: self.currentUserId,
                                                                                  trackListType: .history))
        historyContainer.viewController.tabBarItem.image = UIImage(named: "historyIcon")
        
        let favoriteContainer = TrackListContainer.assemble(with: TrackListContext(moduleOutput: nil,
                                                                                   userId: self.currentUserId,
                                                                                   trackListType: .favorite))
        favoriteContainer.viewController.tabBarItem.image = UIImage(named: "favoriteIcon")
        
        viewControllers = [UINavigationController(rootViewController: profileContainer.viewController),
                           followingContainer.viewController,
                           historyContainer.viewController,
                           favoriteContainer.viewController]

        viewControllers?.forEach {
            $0.tabBarItem.imageInsets.top = 6.0
            $0.tabBarItem.imageInsets.bottom = -6.0
        }
        
        tabBar.isTranslucent = false
        selectedIndex = 0
    }
}

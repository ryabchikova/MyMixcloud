//
//  MainTabBarViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        tabBar.isTranslucent = false
        
        // TODO change this way
        let HARDCODED_USER_ID = "elena-ryabchikova"
                
        let profileContainer = UserProfileContainer.assemble(with: UserProfileContext(moduleOutput: nil, userId: HARDCODED_USER_ID))
        profileContainer.viewController.tabBarItem.image = UIImage(named: "profileIcon")
        
        let followingContainer = FollowingContainer.assemble(with: FollowingContext(moduleOutput: nil))
        followingContainer.viewController.tabBarItem.image = UIImage(named: "followingIcon")
        
        let historyVC = TestViewController(text: "Listening History", background: .yellow)
        historyVC.tabBarItem.image = UIImage(named: "historyIcon")
        
        let favoritesVC = TestViewController(text: "Favorite Tracks", background: .orange)
        favoritesVC.tabBarItem.image = UIImage(named: "favoriteIcon")
        
        
        
        viewControllers = [profileContainer.viewController, followingContainer.viewController, historyVC, favoritesVC]
        
        viewControllers?.forEach {
            $0.tabBarItem.imageInsets.top = 6.0
            $0.tabBarItem.imageInsets.bottom = -6.0
        }
        
        selectedIndex = 0
    }
}

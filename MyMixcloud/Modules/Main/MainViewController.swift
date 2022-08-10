//
//  MainViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController {
	private let output: MainViewOutput

    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTabs(сontrollers: [UIViewController]) {        
        viewControllers = сontrollers.map { UINavigationController(rootViewController: $0) }
        
        viewControllers?.forEach {
            $0.tabBarItem.imageInsets.top = 6.0
            $0.tabBarItem.imageInsets.bottom = -6.0
        }
        
        tabBar.isTranslucent = false
        selectedIndex = 0
    }
}

extension MainViewController: MainViewInput {}

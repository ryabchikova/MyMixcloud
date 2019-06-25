//
//  MainTabBarViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = UIViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        viewControllers = [firstViewController, secondViewController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

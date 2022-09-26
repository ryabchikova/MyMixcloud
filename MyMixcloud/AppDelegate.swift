//
//  AppDelegate.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupCustomAppearance()
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0.5
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = InjectionManager.shared.appRouter().rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

private extension AppDelegate {
    func setupCustomAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.foregroundColor: MMColors.darkGray,
        NSAttributedString.Key.font: MMFonts.largeBold]
        UINavigationBar.appearance().tintColor = MMColors.darkGray
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        UITabBar.appearance().tintColor = MMColors.blue
        UITableViewCell.appearance().selectionStyle = .none
    }
}


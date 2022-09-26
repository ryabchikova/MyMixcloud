//
//  AlertViewModel.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 19.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

struct AlertViewModel {
    let title: String?
    let message: String?
    let actions: [UIAlertAction]
}


//    func showErrorAlert() {
//        let alertController = UIAlertController(title: "Login error",
//                                                message: "User not found. Create account on www.mixcloud.com to use this App.",
//                                                preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        viewController.present(alertController, animated: true, completion: nil)
//    }
//
//    func showLogoutAlert(logoutCompletion: @escaping (UIAlertAction) -> Void) {
//        let alertController = UIAlertController(title: nil,
//                                                message: "Do you want to log out?",
//                                                preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: logoutCompletion))
//        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//        viewController.present(alertController, animated: true, completion: nil)
//    }

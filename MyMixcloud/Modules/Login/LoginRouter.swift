//
//  LoginRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class LoginRouter {
}

extension LoginRouter: LoginRouterInput {
    func showErrorAlert(in viewController: UIViewController) {
        let alertController = UIAlertController(title: "Login error",
                                                message: "User not found. Create account on www.mixcloud.com to use this App.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

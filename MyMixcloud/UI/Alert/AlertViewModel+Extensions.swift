//
//  AlertViewModel+Login.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 19.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

extension AlertViewModel {
    static var login: Self {
        AlertViewModel(
            title: "Login error",
            message: "User not found. Create account on www.mixcloud.com to use this App.",
            actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)]
        )
    }
    
    static func logout(completion: @escaping (UIAlertAction) -> Void) -> Self {
        AlertViewModel(
            title: nil,
            message: "Do you want to log out?",
            actions: [
                UIAlertAction(title: "Yes", style: .default, handler: completion),
                UIAlertAction(title: "No", style: .cancel, handler: nil)
            ]
        )
    }
}

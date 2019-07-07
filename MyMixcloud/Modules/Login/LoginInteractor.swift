//
//  LoginInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
    private let userService: UserService
    private let settingsService: SettingsService
    
    init(userService: UserService, settingsService: SettingsService) {
        self.userService = userService
        self.settingsService = settingsService
    }
}

extension LoginInteractor: LoginInteractorInput {
    func login(with username: String) {
        userService.user(userId: username) { [weak self] user, error in
            DispatchQueue.main.async {
                if user != nil && error == nil {
                    self?.settingsService.setCurrentUserId(username)
                    self?.output?.didLogin()
                } else {
                    self?.output?.loginFailed()
                }
            }
        }
    }
}

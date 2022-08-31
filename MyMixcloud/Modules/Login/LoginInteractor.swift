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
        Task {
            do {
                _ = try await userService.user(userId: username)
                settingsService.setCurrentUserId(username)
                await output?.didLogin()
            } catch {
                await output?.loginFailed()
            }
        }
    }
}

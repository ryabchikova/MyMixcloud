//
//  UserProfileInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
}

extension UserProfileInteractor: UserProfileInteractorInput {
    func loadUser(userId: String) {
        Task.init {
            do {
                let user = try await userService.user(userId: userId)
                await output?.didLoadUser(user)
            } catch let error as MMError {
                await output?.gotError(error)
            } catch {
                await output?.gotError(.executionError)
            }
        }
    }
}

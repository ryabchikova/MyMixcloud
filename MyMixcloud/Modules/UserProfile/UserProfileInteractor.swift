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
        userService.user(userId: userId) { [weak self] user, error in
            if let _ = error {
                self?.output?.gotError()
                return
            }

            if let user = user {
                self?.output?.didLoadUser(user)
            }
        }
    }
}

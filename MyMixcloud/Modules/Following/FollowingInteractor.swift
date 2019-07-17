//
//  FollowingInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class FollowingInteractor {
	weak var output: FollowingInteractorOutput?
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
}

extension FollowingInteractor: FollowingInteractorInput {
    func loadFollowing(userId: String, page: Int, reason: LoadingReason, useCache permit: Bool) {
        userService.following(userId: userId, page: page, useCache: permit) { [weak self] users, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.output?.gotError(error)
                    return
                }

                if let users = users {
                    self?.output?.didLoadFollowing(users, reason: reason)
                }
            }
        }
    }
}

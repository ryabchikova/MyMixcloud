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
    
    private var isLoading = false
    
    init(userService: UserService) {
        self.userService = userService
    }
}

extension FollowingInteractor: FollowingInteractorInput {
    
    func loadFollowing(userId: String, page: Int, reason: LoadingReason) {
        guard !isLoading else {
            return
        }

        isLoading = true
        Task.init {
            defer {
                isLoading = false
            }
            
            do {
                let users = try await userService.following(userId: userId, page: page)
                await output?.didLoadFollowing(users, reason: reason)
            } catch {
                await output?.gotError(error as? MMError ?? .executionError)
            }
            
        }
    }
}

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
    
    func loadUser(userId: String, source: LoadingSource) {
        let completion: (User?, MMError?) -> Void = { [weak self] user, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.output?.gotError(error)
                    return
                }
                
                if let user = user {
                    self?.output?.didLoadUser(user)
                }
            }
        }
        
        switch source {
        case .web:
            userService.user(userId: userId, completionHandler: completion)
        case .cache:
            userService.userFromCache(userId: userId, completionHandler: completion)
        }
    }
}

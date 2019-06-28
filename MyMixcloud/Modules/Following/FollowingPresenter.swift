//
//  FollowingPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class FollowingPresenter {
	weak var view: FollowingViewInput?
    weak var moduleOutput: FollowingModuleOutput?
    
	private let router: FollowingRouterInput
	private let interactor: FollowingInteractorInput
    
    init(router: FollowingRouterInput, interactor: FollowingInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FollowingPresenter: FollowingModuleInput {
}

extension FollowingPresenter: FollowingViewOutput {
    func viewDidLoad() {
        
        // TODO
        let user1 = User(identifier: "BooraID", name: "Boora", country: nil, city: nil, bio: nil, favoritesCount: 1, followersCount: 1, followingCount: 1, profileImage: nil)
        let user2 = User(identifier: "SamsonowID", name: "Boora", country: nil, city: nil, bio: nil, favoritesCount: 1, followersCount: 1, followingCount: 1, profileImage: nil)
        view?.set(viewModels: [FollowingUserViewModel(user: user1), FollowingUserViewModel(user: user2)])
    }
}

extension FollowingPresenter: FollowingInteractorOutput {
}

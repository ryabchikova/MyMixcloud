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
}

extension FollowingPresenter: FollowingInteractorOutput {
}

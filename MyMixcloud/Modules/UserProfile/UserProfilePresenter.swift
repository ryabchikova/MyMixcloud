//
//  UserProfilePresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class UserProfilePresenter {
	weak var view: UserProfileViewInput?

	private let router: RoutingTrait
	private let interactor: UserProfileInteractorInput
    private weak var moduleOutput: UserProfileModuleOutput?
    
    private let userId: String
    
    init(router: RoutingTrait,
         interactor: UserProfileInteractorInput,
         moduleOutput: UserProfileModuleOutput?,
         context: UserProfileContext) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
        userId = context.userId
    }
}

extension UserProfilePresenter: UserProfileModuleInput {}

extension UserProfilePresenter: UserProfileViewOutput {
    func viewWillAppear() {
        view?.showActivity()
        interactor.loadUser(userId: userId)
    }
    
    func didPullToRefresh() {
        interactor.loadUser(userId: userId)
    }
    
    func didTapSettingsButton() {
        router.showSettingsScreen()
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    @MainActor
    func gotError(_ error: MMError) async {
        view?.hideActivity()
        view?.showDummyView(for: error) { [weak self] in
            guard let self = self else { return }
            self.interactor.loadUser(userId: self.userId)
        }
    }
    
    @MainActor
    func didLoadUser(_ user: User) async {
        view?.hideActivity()
        view?.hideDummyViewIfNeed()
        view?.set(userProfileViewModel: UserProfileViewModel(user: user))
    }
}

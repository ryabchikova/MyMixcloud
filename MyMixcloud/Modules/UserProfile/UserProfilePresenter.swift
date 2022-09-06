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

	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    private weak var moduleOutput: UserProfileModuleOutput?
    
    private let userId: String
    
    init(router: UserProfileRouterInput,
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
        if let viewController = view as? UIViewController {
            router.showSettingsScreen(in: viewController)
        }
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    @MainActor
    func gotError(_ error: MMError) async {
        view?.hideActivity()
        
        guard let viewController = view, viewController.isEmpty else {
            return
        }
    
        viewController.showDummyView(for: error) { [weak self] in
            guard let sSelf = self else {
                return
            }
            sSelf.interactor.loadUser(userId: sSelf.userId)
        }
    }
    
    @MainActor
    func didLoadUser(_ user: User) async {
        view?.hideActivity()
        view?.hideDummyViewIfNeed()
        view?.set(userProfileViewModel: UserProfileViewModel(user: user))
    }
}

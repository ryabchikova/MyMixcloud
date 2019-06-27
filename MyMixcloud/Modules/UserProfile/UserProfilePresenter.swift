//
//  UserProfilePresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class UserProfilePresenter {
	weak var view: UserProfileViewInput?
    weak var moduleOutput: UserProfileModuleOutput?
    
	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    private let userId: String
    
    init(userId: String, router: UserProfileRouterInput, interactor: UserProfileInteractorInput) {
        self.userId = userId
        self.router = router
        self.interactor = interactor
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
    func viewDidLoad() {
        view?.showActivity()
        interactor.loadUser(userId: userId)
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    func gotError(_ error: Error?) {
        view?.showDummyView()
    }
    
    func didLoadUser(_ user: User) {
        view?.hideActivity()
        view?.set(userProfileViewModel: UserProfileViewModel(user: user))
    }
}

//
//  UserProfilePresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class UserProfilePresenter {
	weak var view: UserProfileViewInput?
    weak var moduleOutput: UserProfileModuleOutput?
	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    
    private let userId: String
    
    init(router: UserProfileRouterInput, interactor: UserProfileInteractorInput, userId: String) {
        self.router = router
        self.interactor = interactor
        self.userId = userId
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
    func viewWillAppear() {
        interactor.loadUser(userId: userId)
    }
    
    func didTapSettingsButton() {
        if let navigationController = (view as? UIViewController)?.navigationController {
            router.showSettingsScreen(in: navigationController, moduleOutput: self)
        }
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    func gotError() {
        view?.showDummyView()
    }
    
    func didLoadUser(_ user: User) {
        view?.set(userProfileViewModel: UserProfileViewModel(user: user))
    }
}

extension UserProfilePresenter: SettingsModuleOutput {
    func didLogout() {
        moduleOutput?.didLogout()
    }
}

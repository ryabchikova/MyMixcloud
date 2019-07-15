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
        if let viewController = view as? UIViewController {
            router.showSettingsScreen(in: viewController)
        }
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    func gotError(_ error: MMError) {
        
        if let viewController = view {
            
            // TODO запрос данных из кэша
            
            if viewController.isEmpty {
                viewController.showDummyView(for: error) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.interactor.loadUser(userId: self.userId)
                }
            }
        }
    }
    
    func didLoadUser(_ user: User) {
        view?.hideDummyViewIfNeed()
        view?.set(userProfileViewModel: UserProfileViewModel(user: user))
    }
}

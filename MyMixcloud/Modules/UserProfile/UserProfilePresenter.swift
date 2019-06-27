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
    
    init(router: UserProfileRouterInput, interactor: UserProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
}

extension UserProfilePresenter: UserProfileInteractorOutput {
}

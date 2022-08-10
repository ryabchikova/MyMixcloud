//
//  LoginPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class LoginPresenter {
	weak var view: LoginViewInput?

	private let router: LoginRouterInput
	private let interactor: LoginInteractorInput
    private weak var moduleOutput: LoginModuleOutput?
    
    init(router: LoginRouterInput,
         interactor: LoginInteractorInput,
         moduleOutput: LoginModuleOutput?) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

extension LoginPresenter: LoginModuleInput {}

extension LoginPresenter: LoginViewOutput {
    func didTapStart(with username: String) {
        interactor.login(with: username)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    
    func didLogin() {
        moduleOutput?.didLogin()
    }
    
    func loginFailed() {
        if let viewController = view as? UIViewController {             // TODO: можно ли без кастования?
            router.showErrorAlert(in: viewController)
        }
    }
}

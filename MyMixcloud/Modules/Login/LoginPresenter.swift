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

	private let router: RoutingTrait
	private let interactor: LoginInteractorInput
    private weak var moduleOutput: LoginModuleOutput?
    
    init(router: RoutingTrait,
         interactor: LoginInteractorInput,
         moduleOutput: LoginModuleOutput?) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

extension LoginPresenter: LoginModuleInput {}

extension LoginPresenter: LoginViewOutput {
    func viewDidLoad() {
        let model = LoginViewModel { [weak self] username in
            self?.interactor.login(with: username)
        }
        view?.set(viewModel: model)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    
    @MainActor
    func didLogin() async {
        moduleOutput?.didLogin()
    }
    
    @MainActor
    func loginFailed() async {
        router.showAlert(model: .login)
    }
}

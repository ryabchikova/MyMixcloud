//
//  LoginPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class LoginPresenter {
	weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?
    
	private let router: LoginRouterInput
	private let interactor: LoginInteractorInput
    
    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

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
        if let viewController = view as? UIViewController {
            router.showErrorAlert(in: viewController)
        }
    }
}

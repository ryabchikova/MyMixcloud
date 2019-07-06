//
//  LoginContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class LoginContainer {
    let input: LoginModuleInput
	let viewController: UIViewController
	private(set) weak var router: LoginRouterInput!

	class func assemble(with context: LoginContext) -> LoginContainer {
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(router: router, interactor: interactor)
		let viewController = LoginViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return LoginContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LoginModuleInput, router: LoginRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LoginContext {
	weak var moduleOutput: LoginModuleOutput?
}

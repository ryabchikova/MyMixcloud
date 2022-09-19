//
//  LoginModuleBuilder.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 10.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

struct LoginModuleBuilder {

    private init() {}

    static func build(moduleOutput: LoginModuleOutput?) -> Module<LoginModuleInput> {
        let router = Router()
        let interactor = LoginInteractor(userService: InjectionManager.shared.userService(),
                                         settingsService: InjectionManager.shared.settingsService())
        let presenter = LoginPresenter(router: router,
                                       interactor: interactor,
                                       moduleOutput: moduleOutput)
        let viewController = LoginViewController(output: presenter)

        presenter.view = viewController
        router.viewController = viewController
        interactor.output = presenter

        return Module(viewController, presenter)
    }

}

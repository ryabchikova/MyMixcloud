//
//  LoginModuleBuilder.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 10.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

struct LoginModuleBuilder {

    private init() {}

    static func build(with context: LoginContext) -> Module<LoginModuleInput> {
        let router = LoginRouter()
        let interactor = LoginInteractor(userService: InjectionManager.shared.userService(),
                                         settingsService: InjectionManager.shared.settingsService())
        let presenter = LoginPresenter(router: router,
                                       interactor: interactor,
                                    moduleOutput: context.moduleOutput)
        let viewController = LoginViewController(output: presenter)

        presenter.view = viewController
        interactor.output = presenter

        return Module(viewController, presenter)
    }

}

struct LoginContext {
    let moduleOutput: LoginModuleOutput?
}

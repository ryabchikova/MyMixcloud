//
//  FollowingModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


struct FollowingModuleBuilder {
    
    private init() {}

	static func build(_ context: FollowingContext,
                      moduleOutput: FollowingModuleOutput? = nil) -> Module<FollowingModuleInput> {
        let router = Router()
        let interactor = FollowingInteractor(userService: InjectionManager.shared.userService())
        let presenter = FollowingPresenter(router: router,
                                           interactor: interactor,
                                           moduleOutput: moduleOutput,
                                           userId: context.userId)
		let viewController = FollowingViewController(output: presenter)

		presenter.view = viewController
        router.viewController = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

struct FollowingContext {
    let userId: String
}

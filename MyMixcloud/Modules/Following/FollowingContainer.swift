//
//  FollowingContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class FollowingContainer {
    let input: FollowingModuleInput
	let viewController: UIViewController
	private(set) weak var router: FollowingRouterInput!

	class func assemble(with context: FollowingContext) -> FollowingContainer {
        let router = FollowingRouter()
        // TODO there is work for DI container !!!
        let interactor = FollowingInteractor(userService: UserServiceImpl())
        let presenter = FollowingPresenter(router: router, interactor: interactor)
		let viewController = FollowingViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return FollowingContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FollowingModuleInput, router: FollowingRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FollowingContext {
	weak var moduleOutput: FollowingModuleOutput?
}

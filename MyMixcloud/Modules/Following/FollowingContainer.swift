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
        let interactor = FollowingInteractor(userService: InjectionManager.shared.userService())
        let presenter = FollowingPresenter(router: router, interactor: interactor, userId: context.userId)
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
    let userId: String
}

enum LoadingReason {
    case regular
    case pullToRefresh
}

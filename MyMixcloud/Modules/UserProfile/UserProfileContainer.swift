//
//  UserProfileContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class UserProfileContainer {
    let input: UserProfileModuleInput
	let viewController: UIViewController
	private(set) weak var router: UserProfileRouterInput!

	class func assemble(with context: UserProfileContext) -> UserProfileContainer {
        let router = UserProfileRouter()
        // TODO there is work for DI container !!!
        let interactor = UserProfileInteractor(userService: UserServiceImpl())
        let presenter = UserProfilePresenter(userId: context.userId, router: router, interactor: interactor)
		let viewController = UserProfileViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return UserProfileContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: UserProfileModuleInput, router: UserProfileRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct UserProfileContext {
	weak var moduleOutput: UserProfileModuleOutput?
    let userId: String
}

//
//  SettingsContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsContainer {
    let input: SettingsModuleInput
	let viewController: UIViewController
	private(set) weak var router: SettingsRouterInput!

	class func assemble(with context: SettingsContext) -> SettingsContainer {
        let router = SettingsRouter()
        let interactor = SettingsInteractor(settingsService: InjectionManager.shared.settingsService())
        let presenter = SettingsPresenter(router: router, interactor: interactor)
		let viewController = SettingsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return SettingsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SettingsModuleInput, router: SettingsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct SettingsContext {
	weak var moduleOutput: SettingsModuleOutput?
}

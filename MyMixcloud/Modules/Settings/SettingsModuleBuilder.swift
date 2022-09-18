//
//  SettingsModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

struct SettingsModuleBuilder {
    
    private init() {}

	static func build(moduleOutput: SettingsModuleOutput? = nil) -> Module<SettingsModuleInput> {
        let router = SettingsRouter()
        let interactor = SettingsInteractor(settingsService: InjectionManager.shared.settingsService())
        let presenter = SettingsPresenter(router: router,
                                          interactor: interactor,
                                          moduleOutput: moduleOutput)
		let viewController = SettingsViewController(output: presenter)

		presenter.view = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

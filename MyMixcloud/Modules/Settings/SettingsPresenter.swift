//
//  SettingsPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsPresenter {
	weak var view: SettingsViewInput?
    
	private let router: RoutingTrait
	private let interactor: SettingsInteractorInput
    private weak var moduleOutput: SettingsModuleOutput?
    
    init(router: RoutingTrait,
         interactor: SettingsInteractorInput,
         moduleOutput: SettingsModuleOutput?) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

extension SettingsPresenter: SettingsModuleInput {}

extension SettingsPresenter: SettingsViewOutput {
    func viewDidLoad() {
        let viewModels = [
            SettingsViewModel(.logout),
            SettingsViewModel(.cashing(isOn: interactor.isCacheUsageEnabled())) { [weak self] in
                self?.interactor.setCacheUsageEnabled($0)
            },
            SettingsViewModel(.theme)
        ]
        view?.set(viewModels: viewModels)
    }
    
    func didSelectOption(_ option: SettingsOption) {
        switch option {
        case .logout:
            router.showAlert(
                model: .logout { [weak self] _ in
                    self?.interactor.logout()
                }
            )
        case .cashing, .theme:
            return
        }
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
    func didLogout() {
        moduleOutput?.didLogout()
    }
}

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
    
	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput
    private weak var moduleOutput: SettingsModuleOutput?
    
    init(router: SettingsRouterInput,
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
        view?.set(viewModels: [.logout, .theme])
    }
    
    func didSelectItem(_ itemId: String) {
        guard
            let viewController = view as? UIViewController,
            let item = SettingsViewModel(rawValue: itemId)
        else {
            return
        }
        
        switch item {
        case .logout:
            router.showLogoutAlert(in: viewController) { [weak self] _ in
                self?.interactor.logout()
            }
        case .theme:
            return
        }
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
    func didLogout() {
        router.showLoginScreen()
    }
}

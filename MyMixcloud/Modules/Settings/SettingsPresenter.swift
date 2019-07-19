//
//  SettingsPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class SettingsPresenter {
	weak var view: SettingsViewInput?
    weak var moduleOutput: SettingsModuleOutput?
    
	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput
    
    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsModuleInput {
}

extension SettingsPresenter: SettingsViewOutput {
    func didSelectItem(_ item: SettingsItem) {
        guard let viewController = view as? UIViewController else {
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

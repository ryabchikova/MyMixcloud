//
//  MainPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class MainPresenter {
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?
}

extension MainPresenter: MainModuleInput {
}

extension MainPresenter: MainViewOutput {
}

extension MainPresenter: UserProfileModuleOutput {
    func didLogout() {
        moduleOutput?.didLogout()
    }
}

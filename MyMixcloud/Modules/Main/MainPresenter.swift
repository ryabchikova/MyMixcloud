//
//  MainPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


final class MainPresenter {
	weak var view: MainViewInput?
    private weak var moduleOutput: MainModuleOutput?
    
    init(moduleOutput: MainModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
    
}

extension MainPresenter: MainModuleInput {}

extension MainPresenter: MainViewOutput {}

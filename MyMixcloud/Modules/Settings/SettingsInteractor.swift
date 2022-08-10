//
//  SettingsInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?
    private let settingsService: SettingsService
    
    init(settingsService: SettingsService) {
        self.settingsService = settingsService
    }
}

extension SettingsInteractor: SettingsInteractorInput {
    func logout() {
        settingsService.removeCurrentUserId()
        output?.didLogout()
    }
}

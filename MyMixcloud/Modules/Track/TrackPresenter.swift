//
//  TrackPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class TrackPresenter {
	weak var view: TrackViewInput?
    weak var moduleOutput: TrackModuleOutput?
    
	private let router: TrackRouterInput
	private let interactor: TrackInteractorInput
    
    init(router: TrackRouterInput, interactor: TrackInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TrackPresenter: TrackModuleInput {
}

extension TrackPresenter: TrackViewOutput {
}

extension TrackPresenter: TrackInteractorOutput {
}

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
    private let trackId: String
    
    init(router: TrackRouterInput, interactor: TrackInteractorInput, trackId: String) {
        self.router = router
        self.interactor = interactor
        self.trackId = trackId
    }
}

extension TrackPresenter: TrackModuleInput {
}

extension TrackPresenter: TrackViewOutput {
    func viewWillAppear() {
        interactor.loadTrack(trackId: trackId)
    }
}

extension TrackPresenter: TrackInteractorOutput {
    func gotError(_ error: MMError) {
        guard let viewController = view, viewController.isEmpty else {
            return
        }
        
        viewController.showDummyView(for: error) { [weak self] in
            guard let sSelf = self else {
                return
            }
            sSelf.interactor.loadTrack(trackId: sSelf.trackId)
        }
    }
    
    func didLoadTrack(_ track: Track) {
        view?.hideDummyViewIfNeed()
        view?.set(trackViewModel: TrackViewModel(track: track))
    }
}

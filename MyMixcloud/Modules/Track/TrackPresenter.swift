//
//  TrackPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


final class TrackPresenter {
	weak var view: TrackViewInput?
    
	private let interactor: TrackInteractorInput
    private weak var moduleOutput: TrackModuleOutput?

    private let trackId: String
    
    init(interactor: TrackInteractorInput, context: TrackContext) {
        self.interactor = interactor
        moduleOutput = context.moduleOutput
        trackId = context.trackId
    }
}

extension TrackPresenter: TrackModuleInput {}

extension TrackPresenter: TrackViewOutput {
    func viewWillAppear() {
        view?.showActivity()
        interactor.loadTrack(trackId: trackId)
    }
    
    func didPullToRefresh() {
        interactor.loadTrack(trackId: trackId)
    }
}

extension TrackPresenter: TrackInteractorOutput {
    func gotError(_ error: MMError) {
        view?.hideActivity()
        
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
        view?.hideActivity()
        view?.hideDummyViewIfNeed()
        view?.set(trackViewModel: TrackViewModel(track: track))
    }
}

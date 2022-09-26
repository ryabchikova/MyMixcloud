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
    
    init(interactor: TrackInteractorInput,
         moduleOutput: TrackModuleOutput?,
         context: TrackContext) {
        self.interactor = interactor
        self.moduleOutput = moduleOutput
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
    @MainActor
    func gotError(_ error: MMError) async {
        view?.hideActivity()
        view?.showDummyView(for: error) { [weak self] in
            guard let self = self else { return }
            self.interactor.loadTrack(trackId: self.trackId)
        }
    }
    
    @MainActor
    func didLoadTrack(_ track: Track) async {
        view?.hideActivity()
        view?.hideDummyViewIfNeed()
        view?.set(trackViewModel: TrackViewModel(track: track))
    }
}

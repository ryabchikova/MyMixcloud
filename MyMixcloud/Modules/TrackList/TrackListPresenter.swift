//
//  TrackListPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackListPresenter {
	weak var view: TrackListViewInput?
	
    private let router: TrackListRouterInput
	private let interactor: TrackListInteractorInput
    private weak var moduleOutput: TrackListModuleOutput?
    
    private let userId: String
    private let trackListType: TrackListType
    private var nextPage: Int? = 1
    
    var viewIsEmpty: Bool {
        return view?.isEmpty ?? false
    }
    
    init(router: TrackListRouterInput,
         interactor: TrackListInteractorInput,
         moduleOutput: TrackListModuleOutput?,
         context: TrackListContext) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
        userId = context.userId
        trackListType = context.trackListType
    }
}

extension TrackListPresenter: TrackListModuleInput {}

extension TrackListPresenter: TrackListViewOutput {    
    func viewWillAppear() {
        if viewIsEmpty {
            requestNextPage()
        }
    }
    
    func viewDidScrollPage() {
        requestNextPage()
    }
    
    func didPullToRefresh() {
        interactor.loadTrackList(of: trackListType,
                                 userId: userId,
                                 page: 1,
                                 reason: .pullToRefresh)
    }
    
    private func requestNextPage() {
        guard let nextPage = nextPage else {
            return
        }

        interactor.loadTrackList(of: trackListType,
                                 userId: userId,
                                 page: nextPage,
                                 reason: .regular)
    }
    
    func didTapOnTrack(with trackId: String) {
        if let viewController = view as? UIViewController {
            router.showTrackScreen(in: viewController, trackId: trackId)
        }
    }
}

extension TrackListPresenter: TrackListInteractorOutput {
    @MainActor
    func gotError(_ error: MMError) async {
        guard viewIsEmpty else {
            return
        }
        
        view?.showDummyView(for: error) { [weak self] in
            self?.requestNextPage()
        }
    }
    
    @MainActor
    func didLoadTrackList(_ tracks: [Track], reason: LoadingReason) async {
        view?.hideDummyViewIfNeed()

        let viewModels = tracks.map { TrackListItemViewModel(track: $0) }
        nextPage = tracks.isEmpty ? nil : nextPage?.advanced(by: 1)

        switch reason {
        case .regular:
            view?.set(viewModels: viewModels)
        case .pullToRefresh:
            view?.reset(viewModels: viewModels)
        }
    }
}

//
//  TrackListPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class TrackListPresenter {
	weak var view: TrackListViewInput?
    weak var moduleOutput: TrackListModuleOutput?
	private let router: TrackListRouterInput
	private let interactor: TrackListInteractorInput
    
    private let userId: String
    private let trackListType: TrackListType
    private var nextPage: Int? = 1
    private var isLoading = false
    
    var viewIsEmpty: Bool {
        return view?.isEmpty ?? false
    }
    
    init(router: TrackListRouterInput, interactor: TrackListInteractorInput, userId: String, trackListType: TrackListType) {
        self.router = router
        self.interactor = interactor
        self.userId = userId
        self.trackListType = trackListType
    }
}

extension TrackListPresenter: TrackListModuleInput {
}

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
        guard !isLoading else {
            return
        }
        isLoading = true
        interactor.loadTrackList(of: trackListType,
                                 userId: userId,
                                 page: 1,
                                 reason: .pullToRefresh,
                                 useCache: viewIsEmpty)
    }
    
    private func requestNextPage() {
        guard !isLoading, let nextPage = nextPage else {
            return
        }
        isLoading = true
        interactor.loadTrackList(of: trackListType,
                                 userId: userId,
                                 page: nextPage,
                                 reason: .regular,
                                 useCache: viewIsEmpty)
    }
    
    func didTapOnTrack(with trackId: String) {
        if let viewController = view as? UIViewController {
            router.showTrackScreen(in: viewController, trackId: trackId)
        }
    }
}

extension TrackListPresenter: TrackListInteractorOutput {
    func gotError(_ error: MMError) {
        isLoading = false
        
        if let viewController = view, viewController.isEmpty {
            viewController.showDummyView(for: error) { [weak self] in
                self?.requestNextPage()
            }
        }
    }
    
    func didLoadTrackList(_ tracks: [Track], reason: LoadingReason) {
        view?.hideDummyViewIfNeed()
        
        let viewModels = tracks.map { TrackListItemViewModel(track: $0) }
        switch reason {
        case .regular:
            nextPage = tracks.isEmpty ? nil : nextPage?.advanced(by: 1)
            view?.set(viewModels: viewModels)
        case .pullToRefresh:
            nextPage = 2
            view?.reset(viewModels: viewModels)
        }
        
        isLoading = false
    }
}

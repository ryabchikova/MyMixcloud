//
//  TrackListProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

// MARK: - Module
protocol TrackListModuleInput: AnyObject {}

protocol TrackListModuleOutput: AnyObject {}

// MARK: - View
protocol TrackListViewInput: AnyObject {
    var isEmpty: Bool { get }
    func set(viewModels: [TrackListItemViewModel])
    func reset(viewModels: [TrackListItemViewModel])
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
}

protocol TrackListViewOutput: AnyObject {
    func viewWillAppear()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnTrack(with trackId: String)
}

// MARK: - Interactor
protocol TrackListInteractorInput {
    func loadTrackList(of type: TrackListType,
                       userId: String,
                       page: Int,
                       reason: LoadingReason)
}

@MainActor
protocol TrackListInteractorOutput: AnyObject {
    func gotError(_ error: MMError)
    func didLoadTrackList(_ tracks: [Track], reason: LoadingReason)
}

// MARK: - Router
protocol TrackListRouterInput {
    func showTrackScreen(in viewController: UIViewController, trackId: String)
}

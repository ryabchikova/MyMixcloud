//
//  TrackListProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol TrackListModuleInput {
	var moduleOutput: TrackListModuleOutput? { get }
}

protocol TrackListModuleOutput: class {
}

protocol TrackListViewInput: class {
    var isEmpty: Bool { get }
    func set(viewModels: [TrackListItemViewModel])
    func reset(viewModels: [TrackListItemViewModel])
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
    func showActivity()
    func hideActivity()
}

protocol TrackListViewOutput: class {
    func viewWillAppear()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnTrack(with trackId: String)
}

protocol TrackListInteractorInput: class {
    func loadTrackList(of type: TrackListType,
                       userId: String,
                       page: Int,
                       reason: LoadingReason,
                       useCache permit: Bool)
}

protocol TrackListInteractorOutput: class {
    func gotError(_ error: MMError)
    func didLoadTrackList(_ tracks: [Track], reason: LoadingReason)
}

protocol TrackListRouterInput: class {
    func showTrackScreen(in viewController: UIViewController, trackId: String)
}

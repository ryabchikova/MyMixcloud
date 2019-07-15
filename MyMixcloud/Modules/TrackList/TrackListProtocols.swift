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
    func set(viewModels: [TrackListItemViewModel])
    func reset(viewModels: [TrackListItemViewModel])
}

protocol TrackListViewOutput: class {
    func viewDidLoad()
    func viewDidScrollPage()
    func didPullToRefresh()
    func didTapOnTrack(with trackId: String)
}

protocol TrackListInteractorInput: class {
    func loadTrackList(of type: TrackListType, userId: String, page: Int, reason: LoadingReason)
}

protocol TrackListInteractorOutput: class {
    func gotError()
    func didLoadTrackList(_ tracks: [Track], reason: LoadingReason)
}

protocol TrackListRouterInput: class {
    func showTrackScreen(in viewController: UIViewController, trackId: String)
}

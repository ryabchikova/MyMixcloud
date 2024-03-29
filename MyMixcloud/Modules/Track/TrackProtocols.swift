//
//  TrackProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


// MARK: - Module
protocol TrackModuleInput: AnyObject {}

protocol TrackModuleOutput: AnyObject {}

// MARK: - View
protocol TrackViewInput: ActivityIndicatorDisplayable, DummyViewDisplayable {
    func set(trackViewModel: TrackViewModel)
}

protocol TrackViewOutput: AnyObject {
    func viewWillAppear()
    func didPullToRefresh()
}

// MARK: - Interactor
protocol TrackInteractorInput {
    func loadTrack(trackId: String)
}

protocol TrackInteractorOutput: AnyObject {
    func gotError(_ error: MMError) async
    func didLoadTrack(_ track: Track) async
}

//
//  TrackProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol TrackModuleInput {
	var moduleOutput: TrackModuleOutput? { get }
}

protocol TrackModuleOutput: class {
}

protocol TrackViewInput: class {
    var isEmpty: Bool { get }
    func set(trackViewModel: TrackViewModel)
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
}

protocol TrackViewOutput: class {
    func viewWillAppear()
}

protocol TrackInteractorInput: class {
    func loadTrack(trackId: String, useCacheIfNeed permission: Bool)
}

protocol TrackInteractorOutput: class {
    func gotError(_ error: MMError)
    func didLoadTrack(_ track: Track)
}

protocol TrackRouterInput: class {
}

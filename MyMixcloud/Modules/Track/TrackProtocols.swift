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
    func set(trackViewModel: TrackViewModel)
}

protocol TrackViewOutput: class {
    func viewDidLoad()
}

protocol TrackInteractorInput: class {
    func loadTrack(trackId: String)
}

protocol TrackInteractorOutput: class {
    func gotError()
    func didLoadTrack(_ track: Track)
}

protocol TrackRouterInput: class {
}

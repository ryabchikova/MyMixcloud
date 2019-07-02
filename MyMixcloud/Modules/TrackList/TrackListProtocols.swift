//
//  TrackListProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol TrackListModuleInput {
	var moduleOutput: TrackListModuleOutput? { get }
}

protocol TrackListModuleOutput: class {
}

protocol TrackListViewInput: class {
    func set(viewModels: [TrackListItemViewModel])
    func showDummyView()
}

protocol TrackListViewOutput: class {
    func viewDidLoad()
    func viewDidScrollPage()
}

protocol TrackListInteractorInput: class {
    func loadTrackList(of type: TrackListType, userId: String, page: Int)
}

protocol TrackListInteractorOutput: class {
    func gotError()
    func didLoadTrackList(_ tracks: [Track])
}

protocol TrackListRouterInput: class {
}

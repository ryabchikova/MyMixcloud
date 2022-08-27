//
//  TrackInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class TrackInteractor {
	weak var output: TrackInteractorOutput?
    private let trackService: TrackService
    
    init(trackService: TrackService) {
        self.trackService = trackService
    }
}

extension TrackInteractor: TrackInteractorInput {
    func loadTrack(trackId: String) {
        Task {
            let result = await trackService.track(trackId: trackId)
            DispatchQueue.main.async { [weak self] in
                result
                    .onSuccess { self?.output?.didLoadTrack($0) }
                    .onFailure { self?.output?.gotError($0) }
            }
        }
    }
}

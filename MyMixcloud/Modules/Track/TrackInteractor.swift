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
    func loadTrack(trackId: String, useCacheIfNeed permission: Bool) {
        trackService.track(trackId: trackId, useCacheIfNeed: permission) { [weak self] track, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.output?.gotError(error)
                    return
                }
                
                if let track = track {
                    self?.output?.didLoadTrack(track)
                }
            }
        }
    }
}

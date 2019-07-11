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
        trackService.track(trackId: trackId) { [weak self] track, error in
            DispatchQueue.main.async {
                if let _ = error {
                    self?.output?.gotError()
                    return
                }
                
                if let track = track {
                    self?.output?.didLoadTrack(track)
                }
            }
        }
    }
}

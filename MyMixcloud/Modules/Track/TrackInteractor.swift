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
            do {
                let track = try await trackService.track(trackId: trackId)
                await output?.didLoadTrack(track)
            } catch {
                await output?.gotError(error as? MMError ?? .executionError)
            }
        }
    }
}

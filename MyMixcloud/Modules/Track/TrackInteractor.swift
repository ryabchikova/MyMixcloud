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

// TODO: как правильно возвращаться на main thread?
extension TrackInteractor: TrackInteractorInput {
    func loadTrack(trackId: String) {
        Task {
            do {
                let track = try await trackService.track(trackId: trackId)
                DispatchQueue.main.async { [weak self] in
                    self?.output?.didLoadTrack(track)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.output?.gotError(error as? MMError ?? .executionError)
                }
            }
        }
    }
}

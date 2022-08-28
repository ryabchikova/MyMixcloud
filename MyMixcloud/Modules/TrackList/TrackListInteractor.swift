//
//  TrackListInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class TrackListInteractor {
	weak var output: TrackListInteractorOutput?
    private let trackService: TrackService
    
    init(trackService: TrackService) {
        self.trackService = trackService
    }
}

extension TrackListInteractor: TrackListInteractorInput {
    
    func loadTrackList(of type: TrackListType,
                       userId: String,
                       page: Int,
                       reason: LoadingReason) {
        Task {
            do {
                let tracks: [Track]
                switch type {
                case .history:
                    tracks = try await trackService.listeningHistory(userId: userId,
                                                                     page: page)
                case .favorite:
                    tracks = try await trackService.favoriteList(userId: userId,
                                                                 page: page)
                }
                DispatchQueue.main.async { [weak self] in
                    self?.output?.didLoadTrackList(tracks, reason: reason)
                }
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.output?.gotError(error as? MMError ?? .executionError)
                }
            }
        }
    }
}

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
    func loadTrackList(of type: TrackListType, userId: String, page: Int, reason: LoadingReason) {
        
        let completion: ([Track]?, MMError?) -> Void = { [weak self] tracks, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.output?.gotError(error)
                    return
                }
                
                if let tracks = tracks {
                    self?.output?.didLoadTrackList(tracks, reason: reason)
                }
            }
        }
        
        switch type {
        case .history:
            trackService.listeningHistory(userId: userId, page: page, completionHandler: completion)
        case .favorite:
            trackService.favoriteList(userId: userId, page: page, completionHandler: completion)
        }
    }
}

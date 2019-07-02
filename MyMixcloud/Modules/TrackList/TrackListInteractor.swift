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
    func loadTrackList(of type: TrackListType, userId: String, page: Int) {
        
        let completion: ([Track]?, Error?) -> Void = { [weak self] tracks, error in
            if let _ = error {
                self?.output?.gotError()
                return
            }
            
            if let tracks = tracks {
                self?.output?.didLoadTrackList(tracks)
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

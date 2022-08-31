//
//  TrackServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class TrackServiceImpl {
    private let networkService: NetworkService
    private let converter = JsonDataConverter()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension TrackServiceImpl: TrackService {
    
    func track(trackId: String) async throws -> Track {
        guard let url = MixcloudApi.track.requestUrl(identifier: trackId) else {
            throw MMError.executionError
        }
        
        let jsonTrack: JsonTrack = try await networkService.data(url: url)
        return converter.makeTrack(from: jsonTrack)
    }
    
    func listeningHistory(userId: String, page: Int) async throws -> [Track] {
        guard let url = MixcloudApi.history.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        let jsonTrackList: JsonTrackList = try await networkService.data(url: url)
        return converter.makeTrackList(from: jsonTrackList)
    }
    
    func favoriteList(userId: String, page: Int) async throws -> [Track] {
        guard let url = MixcloudApi.favorites.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        let jsonTrackList: JsonTrackList = try await networkService.data(url: url)
        return converter.makeTrackList(from: jsonTrackList)
    }
    
}

//
//  TrackServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class TrackServiceImpl {
    private let networkReachabilityService: NetworkReachabilityService
    private let converter = JsonDataConverter()
    
    init(reachabilityService: NetworkReachabilityService) {
        self.networkReachabilityService = reachabilityService
    }
}

extension TrackServiceImpl: TrackService {
    
    func track(trackId: String) async throws -> Track {
        guard let url = MixcloudApi.track.requestUrl(identifier: trackId) else {
            throw MMError.executionError
        }

        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        let jsonData: Data
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            jsonData = data
            URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data),
                                                for: request)
        } catch {
            guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
                throw MMError.requestError(networkReachabilityService.isReachable(),
                                           at: .callLocation(self, context: #function))
                    .log()
            }
            NSLog("[%@] %@", String.callLocation(self, context: #function), "Get data from cache")
            jsonData = cachedResponse.data
        }
        
        do {
            let jsonTrack: JsonTrack = try JsonHelper.decodedSnakeCaseData(jsonData)
            return converter.makeTrack(from: jsonTrack)
        } catch {
            throw MMError.decodingError(error, at: String(describing: self) + ".\(#function)")
                .log()
        }
    }
    
    func listeningHistory(userId: String, page: Int) async throws -> [Track] {
        guard let url = MixcloudApi.history.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        return try await trackList(url: url)
    }
    
    func favoriteList(userId: String, page: Int) async throws -> [Track] {
        guard let url = MixcloudApi.favorites.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        return try await trackList(url: url)
    }
    
}
    
private extension TrackServiceImpl {
    
    func trackList(url: URL) async throws -> [Track] {
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        let jsonData: Data
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            jsonData = data
            URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data),
                                                for: request)
        } catch {
            guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
                throw MMError.requestError(networkReachabilityService.isReachable(),
                                           at: .callLocation(self, context: #function))
                    .log()
            }
            NSLog("[%@] %@", String.callLocation(self, context: #function), "Get data from cache")
            jsonData = cachedResponse.data
        }
        
        do {
            let jsonTrackList: JsonTrackList = try JsonHelper.decodedSnakeCaseData(jsonData)
            return converter.makeTrackList(from: jsonTrackList)
        } catch {
            throw MMError.decodingError(error, at: .callLocation(self, context: #function))
                .log()
        }
    }
    
}

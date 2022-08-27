//
//  TrackServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import Alamofire

final class TrackServiceImpl {
    private let networkReachabilityService: NetworkReachabilityService
    private let converter = JsonDataConverter()
    private let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(reachabilityService: NetworkReachabilityService) {
        self.networkReachabilityService = reachabilityService
    }
}

extension TrackServiceImpl: TrackService {
    @available(*, deprecated, renamed: "track(trackId:)")
    func track(trackId: String, completionHandler: @escaping (Track?, MMError?) -> Void) {
        guard let url = MixcloudApi.track.requestUrl(identifier: trackId) else {
            return completionHandler(nil, MMError(type: .executionError))
        }
    
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
        
                let data: Data
                if let responseData = response.value {
                    data = responseData
                } else if let request = Alamofire.request(url).request,
                    let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    data = cachedResponse.data
                } else {
                    let error: MMError
                    if sSelf.networkReachabilityService.isReachable() {
                        error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".track",
                                        what: (response.error as? AFError)?.errorDescription)
                    } else {
                        error = MMError(type: .networkUnreachable,
                                        location: String(describing: self) + ".track",
                                        what: nil)
                    }
                    error.log()
                    completionHandler(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonTrack = try decoder.decode(JsonTrack.self, from: data)
                    let track = sSelf.converter.makeTrack(from: jsonTrack)
                    completionHandler(track, nil)
                } catch {
                    let error = MMError(type: .decodingError,
                                        location: String(describing: self) + ".track",
                                        what: (error as? DecodingError)?.localizedDescription)
                    error.log()
                    completionHandler(nil, error)
                }
        }
    }
    
    @available(*, deprecated, renamed: "listeningHistory(userId:page:useCache:)")
    func listeningHistory(userId: String,
                          page: Int,
                          useCache permit: Bool,
                          completionHandler: @escaping ([Track]?, MMError?) -> Void) {
        guard let url = MixcloudApi.history.requestUrl(identifier: userId, page: page) else {
            return completionHandler(nil, .executionError)
        }
        
        trackList(url: url, useCache: permit, completionHandler: completionHandler)
    }
    
    @available(*, deprecated, renamed: "favoriteList(userId:page:useCache:)")
    func favoriteList(userId: String,
                      page: Int,
                      useCache permit: Bool,
                      completionHandler: @escaping ([Track]?, MMError?) -> Void) {
        guard let url = MixcloudApi.favorites.requestUrl(identifier: userId, page: page) else {
            return completionHandler(nil, .executionError)
        }

        trackList(url: url, useCache: permit, completionHandler: completionHandler)
    }
    
    // MARK: - async

    func track(trackId: String) async throws -> Track {
        guard let url = MixcloudApi.track.requestUrl(identifier: trackId) else {
            throw MMError.executionError
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw MMError.webServiceError
        }
        
        do {
            let jsonTrack: JsonTrack = try JsonHelper.decodedSnakeCaseData(data)
            return converter.makeTrack(from: jsonTrack)
        } catch {
            let error = MMError(type: .decodingError,
                                location: String(describing: self) + ".\(#function)",
                                what: (error as? DecodingError)?.localizedDescription)
            error.log()
            throw error
        }
    }
    
    func listeningHistory(userId: String,
                          page: Int,
                          useCache permit: Bool) async throws -> [Track] {
        guard let url = MixcloudApi.history.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        return try await trackList(url: url, useCache: permit)
    }
    
    func favoriteList(userId: String,
                      page: Int,
                      useCache permit: Bool) async throws -> [Track] {
        guard let url = MixcloudApi.favorites.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        return try await trackList(url: url, useCache: permit)
    }
}
    
private extension TrackServiceImpl {
    @available(*, deprecated, renamed: "trackList(url:useCache:)")
    func trackList(url: URL,
                   useCache: Bool,
                   completionHandler: @escaping ([Track]?, MMError?) -> Void) {
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
                
                let data: Data
                if let responseData = response.value {
                    data = responseData
                } else if useCache, let request = Alamofire.request(url).request,
                    let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    data = cachedResponse.data
                } else {
                    let error: MMError
                    if sSelf.networkReachabilityService.isReachable() {
                        error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".trackList",
                                        what: (response.error as? AFError)?.errorDescription)
                    } else {
                        error = MMError(type: .networkUnreachable,
                                        location: String(describing: self) + ".trackList",
                                        what: nil)
                    }
                    error.log()
                    completionHandler(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonTrackList = try decoder.decode(JsonTrackList.self, from: data)
                    let trackList = sSelf.converter.makeTrackList(from: jsonTrackList)
                    completionHandler(trackList, nil)
                } catch {
                    let error = MMError(type: .decodingError,
                                        location: String(describing: self) + ".trackList",
                                        what: (error as? DecodingError)?.localizedDescription)
                    error.log()
                    completionHandler(nil, error)
                }
            }
    }
    
    func trackList(url: URL, useCache: Bool) async throws -> [Track] {
        let data: Data
        do {
            (data, _) = try await URLSession.shared.data(from: url)
        } catch {
            guard
                useCache,
                let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url))
            else {
                throw MMError.webServiceError
            }
            
            data = cachedResponse.data
        }
        
        do {
            let jsonTrackList: JsonTrackList = try JsonHelper.decodedSnakeCaseData(data)
            return converter.makeTrackList(from: jsonTrackList)
        } catch {
            let error = MMError(type: .decodingError,
                                location: String(describing: self) + ".\(#function)",
                                what: (error as? DecodingError)?.localizedDescription)
            error.log()
            throw error
        }
    }
    
}

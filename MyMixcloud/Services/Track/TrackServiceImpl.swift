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
    func track(trackId: String, completionHandler: @escaping (Track?, MMError?) -> Void) {
        let url = MixcloudApi.track.requestUrl(identifier: trackId)
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
    
    func listeningHistory(userId: String,
                          page: Int,
                          useCache permit: Bool,
                          completionHandler: @escaping ([Track]?, MMError?) -> Void) {
        let url = MixcloudApi.history.requestUrl(identifier: userId, page: page)
        trackList(url: url, useCache: permit, completionHandler: completionHandler)
    }
    
    func favoriteList(userId: String,
                      page: Int,
                      useCache permit: Bool,
                      completionHandler: @escaping ([Track]?, MMError?) -> Void) {
        let url = MixcloudApi.favorites.requestUrl(identifier: userId, page: page)
        trackList(url: url, useCache: permit, completionHandler: completionHandler)
    }
    
    // MARK: - async

    func track(trackId: String) async -> Swift.Result<Track, MMError> {
        guard let url = try? MixcloudApi.track.requestUrl(identifier: trackId).asURL() else {
            return .failure(.executionError)
        }
        
        let session = URLSession.shared
        guard let (data, _) = try? await session.data(from: url) else {
            return .failure(.webServiceError)
        }
        
        do {
            let jsonTrack: JsonTrack = try JsonHelper.decodedSnakeCaseData(data)
            return .success(converter.makeTrack(from: jsonTrack))
        } catch {
            let error = MMError(type: .decodingError,
                                location: String(describing: self) + ".\(#function)",
                                what: (error as? DecodingError)?.localizedDescription)
            error.log()
            return .failure(error)
        }
    }

}
    
private extension TrackServiceImpl {
     func trackList(url: String,
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
}

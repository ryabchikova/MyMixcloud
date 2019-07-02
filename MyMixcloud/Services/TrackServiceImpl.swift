//
//  TrackServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import Alamofire

final class TrackServiceImpl: TrackService {
    private let converter = JsonDataConverter()
    private let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    func track(trackId: String, completionHandler: @escaping (Track?, Error?) -> Void) {
        completionHandler(nil, nil)
    }
    
    func listeningHistory(userId: String, page: Int, completionHandler: @escaping ([Track]?, Error?) -> Void) {
        let url = MixcloudApi.history.requestUrl(userId: userId, page: page)
        trackList(url: url, completionHandler: completionHandler)
    }
    
    func favoriteList(userId: String, page: Int, completionHandler: @escaping ([Track]?, Error?) -> Void) {
        let url = MixcloudApi.favorites.requestUrl(userId: userId, page: page)
        trackList(url: url, completionHandler: completionHandler)
    }
    
    private func trackList(url: String, completionHandler: @escaping ([Track]?, Error?) -> Void) {
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let data = response.result.value else {
                    let error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".trackList",
                                        what: (response.result.error as? AFError)?.errorDescription)
                    error.log()
                    completionHandler(nil, response.result.error)
                    return
                }
                
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
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

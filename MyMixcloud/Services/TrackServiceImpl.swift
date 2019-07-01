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
    
//    func listeningHistory(userId: String, page: Int, completionHandler: @escaping ([Track]?, Error?) -> Void) {
//        let url = MixcloudApi.history.requestUrl(userId: userId, page: page)
//
//        Alamofire.request(url)
//            .validate()
//            .responseData(queue: dispatchQueue) { [weak self] response in
//                guard let data = response.result.value else {
//                    completionHandler(nil, response.result.error)
//                    return
//                }
//
//                guard let sSelf = self else {
//                    completionHandler(nil, MMError.executionError(description: "User request failed"))
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let jsonTrackList = try decoder.decode(JsonTrackList.self, from: data)
//                    let trackList = sSelf.converter.makeTrackList(from: jsonTrackList)
//                    completionHandler(trackList, nil)
//                } catch {
//                    completionHandler(nil, error)
//                }
//        }
//    }
    
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
                    completionHandler(nil, response.result.error)
                    return
                }
                
                guard let sSelf = self else {
                    completionHandler(nil, MMError.executionError(description: "User request failed"))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonTrackList = try decoder.decode(JsonTrackList.self, from: data)
                    let trackList = sSelf.converter.makeTrackList(from: jsonTrackList)
                    completionHandler(trackList, nil)
                } catch {
                    if let error = error as? DecodingError {
                        print(error.errorDescription)
                        print(error.localizedDescription)
                        print(error.failureReason)
                        completionHandler(nil, error)
                    }
                }
            }
    }
}

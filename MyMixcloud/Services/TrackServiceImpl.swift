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
        completionHandler(nil, nil)
    }
    
    func favoriteList(userId: String, page: Int, completionHandler: @escaping ([Track]?, Error?) -> Void) {
        completionHandler(nil, nil)
    }
}

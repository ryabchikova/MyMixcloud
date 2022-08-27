//
//  TrackService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

/// - parameter page: starting from 1
protocol TrackService {
    func track(trackId: String, completionHandler: @escaping (Track?, MMError?) -> Void)
    func track(trackId: String) async -> Result<Track, MMError>
    
    func listeningHistory(userId: String,
                          page: Int,
                          useCache permit: Bool,
                          completionHandler: @escaping ([Track]?, MMError?) -> Void)
    
    func favoriteList(userId: String,
                      page: Int,
                      useCache permit: Bool,
                      completionHandler: @escaping ([Track]?, MMError?) -> Void)
}

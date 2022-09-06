//
//  caching.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 01.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

/*
// Full variant
let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
let jsonData: Data
do {
    let (data, response) = try await URLSession.shared.data(for: request)
    jsonData = data
    URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
} catch {
    guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
        throw MMError.requestError(networkReachabilityService.isReachable(),
                                   at: .callLocation(self, context: #function))
            .log()
    }
    jsonData = cachedResponse.data
}
 */

/*
 // Short variant
 let jsonData: Data
 do {
     let (data, _) = try await URLSession.shared.data(from: url)
     jsonData = data
 } catch {
     guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
         throw MMError.requestError(networkReachabilityService.isReachable(),
                                    at: .callLocation(self, context: #function))
             .log()
     }
     jsonData = cachedResponse.data
 }
 */

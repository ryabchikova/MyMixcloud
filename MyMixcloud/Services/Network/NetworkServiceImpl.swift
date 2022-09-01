//
//  NetworkServiceImpl.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 31.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation


final class NetworkServiceImpl {
    private let networkReachabilityService: NetworkReachabilityService
    
    init(reachabilityService: NetworkReachabilityService) {
        self.networkReachabilityService = reachabilityService
    }
}

extension NetworkServiceImpl: NetworkService {

    func data<T: Decodable>(url: URL) async throws -> T {
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        let jsonData: Data
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            jsonData = data
            URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data),
                                                for: request)
        } catch {
            guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
                throw MMError.requestError(isNetworkReachable).log()
            }
            print("[DBG] Get data from cache")
            jsonData = cachedResponse.data
        }
        
        do {
            return try JsonHelper.decodedSnakeCaseData(jsonData)
        } catch {
            throw MMError.decodingError(error).log()
        }
    }
}

private extension NetworkServiceImpl {
    
    var isNetworkReachable: Bool {
        networkReachabilityService.isReachable()
    }
    
}

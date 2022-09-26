//
//  NetworkReachabilityServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 13/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkReachabilityServiceImpl: NetworkReachabilityService {
    private let reachabilityManager = NetworkReachabilityManager()
    
    func isReachable() -> Bool {
        reachabilityManager?.isReachable ?? true
    }
}

//
//  MixcloudApi.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

enum MixcloudApi {
    case user
    case track
    case history
    case favorites
    case following
    
    private var baseUrl: String {
        return "https://api.mixcloud.com"
    }
    
    func requestUrl(identifier: String, page: Int? = nil) -> URL? {
        let userUrl = baseUrl + "/" + identifier + "/"
        
        let page = page ?? 0
        let offset = page < 1 ? 0 : (page - 1) * Constants.limit
        let parameters = "?limit=" + Constants.limit.description + "&offset=" + offset.description
        
        let value: String
        switch self {
            case .user:
                value = userUrl
            case .track:
                value = baseUrl + identifier
            case .history:
                value = userUrl + "listens/" + parameters
            case .favorites:
                value = userUrl + "favorites/" + parameters
            case .following:
                value = userUrl + "following/" + parameters
        }
        
        return URL(string: value)
    }
}

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
    case history
    case favorites
    case following
    
    private var baseUrl: String {
        return "https://api.mixcloud.com/"
    }
    
    func requestUrl(userId: String, page: Int? = nil) -> String {
        let userUrl = baseUrl + userId + "/"
        
        switch self {
            case .user:
                return userUrl
            case .history:
                return userUrl + "listens/"
            case .favorites:
                return userUrl + "favorites/"
            case .following:                
                let page = page ?? 0
                let offset = page < 1 ? 0 : (page - 1) * Constants.limit
                return userUrl + "following/?limit=" + Constants.limit.description + "&offset=" + offset.description
        }
    }
}

//let url1 = MixcloudApi.user.requestUrl(userIdentifier: "asm")
//let url2 = MixcloudApi.following.requestUrl(userIdentifier: "asm")





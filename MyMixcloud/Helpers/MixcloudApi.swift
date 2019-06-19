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
    
    func requestUrl(userIdentifier: String) -> String {
        let userUrl = baseUrl + userIdentifier + "/"
        
        switch self {
            case .user:
                return userUrl
            case .history:
                return userUrl + "listens/"
            case .favorites:
                return userUrl + "favorites/"
            case .following:
                return userUrl + "following/?limit=" + Constants.limit.description + "&offset=0"
        }
    }
}

//let url1 = MixcloudApi.user.requestUrl(userIdentifier: "asm")
//let url2 = MixcloudApi.following.requestUrl(userIdentifier: "asm")





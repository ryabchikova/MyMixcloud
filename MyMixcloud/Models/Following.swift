//
//  Following.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 17/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct Following: Decodable {

    private let users: [User]
    private let paging: Paging      // TODO это м.б. не нужно
    
    private enum CodingKeys: String, CodingKey {
        case users = "data"
        case paging
    }
    
    private struct User: Decodable {
        let identifier: String
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "username"
        }
    }
    
    // TODO вынести отдельно
    struct Paging: Decodable {
        let next: String?
    }
}

extension Following {
    var userIds: [String] {
        return users.map{$0.identifier}
    }
    
    var hasNextPage: Bool {
        return paging.next != nil
    }
}



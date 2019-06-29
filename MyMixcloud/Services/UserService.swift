//
//  UserService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

/// - parameter page: starting from 1
protocol UserService {
    func user(userId: String, completionHandler: @escaping (User?, Error?) -> Void)
    func followingList(userId: String, page: Int, completionHandler: @escaping ([String]?, Error?) -> Void)
    func following(userId: String, page: Int, completionHandler: @escaping ([User]?, Error?) -> Void)
}



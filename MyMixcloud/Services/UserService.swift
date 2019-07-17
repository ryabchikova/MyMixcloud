//
//  UserService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol UserService {
    func user(userId: String, completionHandler: @escaping (User?, MMError?) -> Void)
    /// - parameter page: starting from 1
    func following(userId: String, page: Int, completionHandler: @escaping ([User]?, MMError?) -> Void)
}



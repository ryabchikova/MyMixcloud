//
//  UserService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol UserService {
    @available(*, deprecated, renamed: "user(userId:)")
    func user(userId: String, completionHandler: @escaping (User?, MMError?) -> Void)
    
    /// - parameter page: starting from 1
    @available(*, deprecated, renamed: "following(userId:page:)")
    func following(userId: String, page: Int, useCache permit: Bool, completionHandler: @escaping ([User]?, MMError?) -> Void)
    
    func user(userId: String) async throws -> User
    
    /// - parameter page: starting from 1
    func following(userId: String, page: Int) async throws -> [User]
}

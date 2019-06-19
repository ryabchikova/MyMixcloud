//
//  UserService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol UserService {
    func user(identifier: String, queue: DispatchQueue?, completionHandler: @escaping (User?, Error?) -> Void)
    func following(identifier: String, queue: DispatchQueue?, completionHandler: @escaping (Following?, Error?) -> Void)
    //func followingUsers(identifier: String, queue: DispatchQueue?, completionHandler: @escaping ([User]?, Error?) -> Void)
    func printFollowingUsers(identifier: String, queue: DispatchQueue?)
}



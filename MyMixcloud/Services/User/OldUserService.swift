//
//  OldUserService.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 01.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//


import Foundation

// Оставляю сарую реализацию для удобства стравнения с новым стилем
protocol OldUserService {
    func user(userId: String, completionHandler: @escaping (User?, MMError?) -> Void)
    
    /// - parameter page: starting from 1
    func following(userId: String, page: Int, useCache permit: Bool, completionHandler: @escaping ([User]?, MMError?) -> Void)
}

//
//  UserServiceImpl.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 17/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import Alamofire

final class UserServiceImpl: UserService {
    
    func user(identifier: String, queue: DispatchQueue? = nil, completionHandler: @escaping (User?, Error?) -> Void) {
        let url = MixcloudApi.user.requestUrl(userIdentifier: identifier)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: queue) { response in
                guard let data = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data)
                    completionHandler(user, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
    }
    
    func following(identifier: String, queue: DispatchQueue? = nil, completionHandler: @escaping (Following?, Error?) -> Void) {
        let url = MixcloudApi.following.requestUrl(userIdentifier: identifier)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: queue) { response in
                guard let data = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let following = try decoder.decode(Following.self, from: data)
                    completionHandler(following, nil)
                } catch {
                    completionHandler(nil, error)
                }
        }
    }
    
    //func followingUsers(identifier: String, queue: DispatchQueue? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
    func printFollowingUsers(identifier: String, queue: DispatchQueue?) {
        following(identifier: identifier, queue: queue) { [weak self] following, error in
            guard let following = following, error == nil else {
                return
            }
            
            guard let self = self else {
                return
            }
            
            let serialQueue = DispatchQueue(label: "mySerialQueue", qos: .userInitiated)
            
            for identifier in following.identifiers {
                print("ask for \(identifier)")
                self.user(identifier: identifier, queue: serialQueue) { user, _ in
                    if let user = user {
                        print("a'm follow \(user.name) from \(user.city)")
                    }
                }
            }
        }
    }
}

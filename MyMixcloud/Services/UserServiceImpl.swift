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
    
    func users(identifiers: [String], queue: DispatchQueue? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
        var users: [User?] = Array(repeating: nil, count: identifiers.count)
        let group = DispatchGroup()
        let arrayAccessOueue = DispatchQueue(label: "ArrayAccessOueue", attributes: .concurrent)
        
        for (index, identifier) in identifiers.enumerated() {
            group.enter()
            self.user(identifier: identifier, queue: queue) { user, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                
                arrayAccessOueue.sync(flags:.barrier) {
                    print("add new user \(user?.name ?? "")")
                    users[index] = user
                }
                print("leave group with user \(user?.name ?? "")")
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completionHandler(users.compactMap {$0}, nil)
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
    
//    func followingUsers(identifier: String, queue: DispatchQueue? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
//        following(identifier: identifier, queue: queue) { [weak self] following, error in
//            guard let following = following, error == nil else {
//                completionHandler(nil, error)
//                return
//            }
//            
//            guard let self = self else {
//                completionHandler(nil, error)
//                return
//            }
//            
//            var users: [User?] = Array(repeating: nil, count: following.identifiers.count)
//            let group = DispatchGroup()
//            
//            for (index, identifier) in following.identifiers.enumerated() {
//                group.enter()
//                self.user(identifier: identifier, queue: queue) { user, error in
//                    if let error = error {
//                        completionHandler(nil, error)
//                        return
//                    }
//                    
//                    users[index] = user
//                    group.leave()
//                }
//            }
//            
//            group.notify(queue: DispatchQueue.main) {
//                completionHandler(users.compactMap {$0}, nil)
//            }
//        }
//    }
    
    
}

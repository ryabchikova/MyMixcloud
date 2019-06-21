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
    
    private let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    func user(userId: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let url = MixcloudApi.user.requestUrl(userId: userId)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { response in
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
    
    func following(userId: String, page: Int, completionHandler: @escaping ([User]?, Error?) -> Void) {
        followingList(userId: userId, page: page) { [weak self] following, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let followingList = following?.userIds, let sSelf = self else {
                completionHandler(nil, MixcloudError.serverError(description: "Get Following list failed"))
                return
            }
            
            guard !followingList.isEmpty else {
                // it's not error, just has no more items
                completionHandler([], nil)
                return
            }
            
            var users: [User?] = Array(repeating: nil, count: followingList.count)
            let arrayAccessQueue = DispatchQueue(label: "ArrayAccessQueue", attributes: .concurrent)
            let group = DispatchGroup()
            
            for (index, userId) in followingList.enumerated() {
                group.enter()
                sSelf.user(userId: userId) { user, error in
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    
                    arrayAccessQueue.async(flags:.barrier) {
                        // use index to store User objects in the same order as input following list
                        users[index] = user
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                completionHandler(users.compactMap {$0}, nil)
            }
        }
    }
    
    private func followingList(userId: String, page: Int, completionHandler: @escaping (Following?, Error?) -> Void) {
        let url = MixcloudApi.following.requestUrl(userId: userId, page: page)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { response in
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
}

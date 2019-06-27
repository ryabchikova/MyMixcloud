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
    
    private let converter = JsonDataConverter()
    private let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    func user(userId: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let url = MixcloudApi.user.requestUrl(userId: userId)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let data = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                
                guard let sSelf = self else {
                    completionHandler(nil, MMError.serverError(description: "User request failed"))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonUser = try decoder.decode(JsonUser.self, from: data)
                    let user = sSelf.converter.makeUser(from: jsonUser)
                    completionHandler(user, nil)
                } catch {
                    completionHandler(nil, error)
                }
        }
    }
    
    func followingList(userId: String, page: Int, completionHandler: @escaping ([String]?, Error?) -> Void) {
        let url = MixcloudApi.following.requestUrl(userId: userId, page: page)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let data = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                
                guard let sSelf = self else {
                    completionHandler(nil, MMError.serverError(description: "Following list request failed"))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let jsonFollowing = try decoder.decode(JsonFollowing.self, from: data)
                    let followingList = sSelf.converter.makeFollowingList(from: jsonFollowing)
                    completionHandler(followingList, nil)
                } catch {
                    completionHandler(nil, error)
                }
        }
    }
    
    func following(userId: String, page: Int, completionHandler: @escaping ([User]?, Error?) -> Void) {
        followingList(userId: userId, page: page) { [weak self] followingList, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }

            guard let followingList = followingList, let sSelf = self else {
                completionHandler(nil, MMError.serverError(description: "Following request failed"))
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
}
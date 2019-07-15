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
    
    private let networkReachabilityService: NetworkReachabilityService
    private let converter = JsonDataConverter()
    private let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(reachabilityService: NetworkReachabilityService) {
        self.networkReachabilityService = reachabilityService
    }
    
    func user(userId: String, completionHandler: @escaping (User?, MMError?) -> Void) {
        let url = MixcloudApi.user.requestUrl(identifier: userId)
        
//        if let cachedResponse = URLCache.shared.cachedResponse(for: Alamofire.request(url).request!) {
//            //print("cachedResponse: \(cachedResponse.data)")
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let jsonUser = try decoder.decode(JsonUser.self, from: cachedResponse.data)
//                let user = converter.makeUser(from: jsonUser)
//                completionHandler(user, nil)
//                print("**** Return User from cache: ")
//                return
//            } catch {
//                print("*** error when decode user from cache ", error)
//            }
//        }

        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
                
                guard let data = response.result.value else {
                    let error: MMError
                    if sSelf.networkReachabilityService.isReachable() {
                        error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".user",
                                        what: (response.result.error as? AFError)?.errorDescription)
                    } else {
                        error = MMError(type: .networkUnreachable,
                                        location: String(describing: self) + ".user",
                                        what: nil)
                    }
                    
                    error.log()
                    completionHandler(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonUser = try decoder.decode(JsonUser.self, from: data)
                    let user = sSelf.converter.makeUser(from: jsonUser)
                    completionHandler(user, nil)
                } catch {
                    let error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".user",
                                        what: (error as? DecodingError)?.localizedDescription)
                    error.log()
                    completionHandler(nil, error)
                }
        }
    }
    
    private func followingList(userId: String, page: Int, completionHandler: @escaping ([String]?, Error?) -> Void) {
        let url = MixcloudApi.following.requestUrl(identifier: userId, page: page)
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let data = response.result.value else {
                    completionHandler(nil, response.result.error)
                    let error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".followingList",
                                        what: (response.result.error as? AFError)?.errorDescription)
                    error.log()
                    return
                }
                
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonFollowing = try decoder.decode(JsonFollowing.self, from: data)
                    let followingList = sSelf.converter.makeFollowingList(from: jsonFollowing)
                    completionHandler(followingList, nil)
                } catch {
                    let error = MMError(type: .decodingError,
                                        location: String(describing: self) + ".followingList",
                                        what: (error as? DecodingError)?.localizedDescription)
                    error.log()
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

            guard let sSelf = self else {
                completionHandler(nil, MMError(type: .executionError))
                return
            }
            
            guard let followingList = followingList else {
                completionHandler(nil, error)
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

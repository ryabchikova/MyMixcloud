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
        guard let url = MixcloudApi.user.requestUrl(identifier: userId) else {
            return completionHandler(nil, .executionError)
        }

        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
                
                let data: Data
                if let responseData = response.result.value {
                    data = responseData
                } else if let request = Alamofire.request(url).request,
                    let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    data = cachedResponse.data
                } else {
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
                    let error = MMError(type: .decodingError,
                                        location: String(describing: self) + ".user",
                                        what: (error as? DecodingError)?.localizedDescription)
                    error.log()
                    completionHandler(nil, error)
                }
        }
    }
    
    func following(userId: String,
                   page: Int,
                   useCache permit: Bool,
                   completionHandler: @escaping ([User]?, MMError?) -> Void) {
        followingList(userId: userId, page: page, useCache: permit) { [weak self] followingList, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let sSelf = self, let followingList = followingList else {
                completionHandler(nil, MMError(type: .executionError))
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
    
    private func followingList(userId: String,
                               page: Int,
                               useCache: Bool,
                               completionHandler: @escaping ([String]?, MMError?) -> Void) {
        guard let url = MixcloudApi.following.requestUrl(identifier: userId, page: page) else {
            return completionHandler(nil, .executionError)
        }
        
        Alamofire.request(url)
            .validate()
            .responseData(queue: dispatchQueue) { [weak self] response in
                guard let sSelf = self else {
                    completionHandler(nil, MMError(type: .executionError))
                    return
                }
                
                let data: Data
                if let responseData = response.result.value {
                    data = responseData
                } else if useCache, let request = Alamofire.request(url).request,
                    let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    data = cachedResponse.data
                } else {
                    let error: MMError
                    if sSelf.networkReachabilityService.isReachable() {
                        error = MMError(type: .webServiceError,
                                        location: String(describing: self) + ".followingList",
                                        what: (response.result.error as? AFError)?.errorDescription)
                    } else {
                        error = MMError(type: .networkUnreachable,
                                        location: String(describing: self) + ".followingList",
                                        what: nil)
                    }
                    error.log()
                    completionHandler(nil, error)
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
}

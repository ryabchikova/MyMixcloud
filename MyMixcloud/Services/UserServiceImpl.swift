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
        let arrayAccessQueue = DispatchQueue(label: "ArrayAccessQueue", attributes: .concurrent)
        
        let group = DispatchGroup()
        
        for (index, identifier) in identifiers.enumerated() {
            group.enter()
            self.user(identifier: identifier, queue: queue) { user, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                
                arrayAccessQueue.sync(flags:.barrier) {
                    // index use for store User objects in the same order as input identifiers
                    users[index] = user
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completionHandler(users.compactMap {$0}, nil)
        }
    }
    
    func following(identifier: String,
                   queue: DispatchQueue? = nil,
                   requestUrl: String? = nil,
                   completionHandler: @escaping (Following?, Error?) -> Void) {
        
        Alamofire.request(requestUrl ?? MixcloudApi.following.requestUrl(userIdentifier: identifier))
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
    
    // Это Ок
    func usersSemaphore(identifiers: [String], queue: DispatchQueue? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
        var users: [User?] = Array(repeating: nil, count: identifiers.count)
        
        let semaphore = DispatchSemaphore(value: 1)
        let group = DispatchGroup()
        
        for (index, identifier) in identifiers.enumerated() {
            group.enter()
            self.user(identifier: identifier, queue: queue) { user, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                
                semaphore.wait()
                users[index] = user
                group.leave()
                semaphore.signal()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completionHandler(users.compactMap {$0}, nil)
        }
    }
    
    // Не подходит, задания выполняются не по порядку
    func usersOnSerialQueue(identifiers: [String], completionHandler: @escaping ([User]?, Error?) -> Void) {
        print(identifiers)
        
        var users = [User?]()
        
        let serialQueue = DispatchQueue(label: "SerialQueue")
        let group = DispatchGroup()

        for identifier in identifiers {
            group.enter()
            self.user(identifier: identifier, queue: serialQueue) { user, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }

                print("get user \(user?.name)")
                users.append(user)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completionHandler(users.compactMap {$0}, nil)
        }
    }
    
}

//
//  whatever.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 19/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

func getResource(id: Int, completion: @escaping(Int) -> Void) {
    print("getting resource \(id)")
    sleep(1)
    completion(id)
}

func getArrayOfResourcesSerially(completion: @escaping([Int]) -> Void) {
    
    print("Do work serially")
    
    let serialQueue = DispatchQueue(label: "mySerialQueue", qos: .userInitiated)
    let idsToGet = 1...10
    var results = [Int]()
    
    DispatchQueue.global().sync {
        
        for i in idsToGet {
            serialQueue.async {
                getResource(id: i) { value in
                    results.append(value)
                }
            }
        }
        serialQueue.async {
            completion(results)
        }
    }
}

func getArrayOfResourcesConcurently() {
    
    print("Do work concurently")
    
    let concurentQueue = DispatchQueue.global()
    let idsToGet = 1...10
    var results = [Int]()
    
    for i in idsToGet {
        concurentQueue.async {
            getResource(id: i) { value in
                results.append(value)
            }
        }
    }
    
    sleep(10)
    print(results)
}


/* ЭТУ БЕРЕМ
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
 
 //                arrayAccessQueue.sync(flags:.barrier) {
 //                    // index use for store User objects in the same order as input identifiers
 //                    users[index] = user
 //                }
 //                group.leave()
 
 arrayAccessQueue.async(flags:.barrier) {
 // index use for store User objects in the same order as input identifiers
 users[index] = user
 group.leave()
 }
 }
 }
 
 group.notify(queue: DispatchQueue.main) {
 completionHandler(users.compactMap {$0}, nil)
 }
 }
 */


// Это Ок
//    func usersSemaphore(identifiers: [String], queue: DispatchQueue? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
//        var users: [User?] = Array(repeating: nil, count: identifiers.count)
//
//        let semaphore = DispatchSemaphore(value: 1)
//        let group = DispatchGroup()
//
//        for (index, identifier) in identifiers.enumerated() {
//            group.enter()
//            self.user(identifier: identifier, queue: queue) { user, error in
//                if let error = error {
//                    completionHandler(nil, error)
//                    return
//                }
//
//                semaphore.wait()
//                users[index] = user
//                group.leave()
//                semaphore.signal()
//            }
//        }
//
//        group.notify(queue: DispatchQueue.main) {
//            completionHandler(users.compactMap {$0}, nil)
//        }
//    }

// Не подходит, задания выполняются не по порядку
//    func usersOnSerialQueue(identifiers: [String], completionHandler: @escaping ([User]?, Error?) -> Void) {
//        print(identifiers)
//
//        var users = [User?]()
//
//        let serialQueue = DispatchQueue(label: "SerialQueue")
//        let group = DispatchGroup()
//
//        for identifier in identifiers {
//            group.enter()
//            self.user(identifier: identifier, queue: serialQueue) { user, error in
//                if let error = error {
//                    completionHandler(nil, error)
//                    return
//                }
//
//                print("get user \(user?.name)")
//                users.append(user)
//                group.leave()
//            }
//        }
//
//        group.notify(queue: DispatchQueue.main) {
//            completionHandler(users.compactMap {$0}, nil)
//        }
//    }
//


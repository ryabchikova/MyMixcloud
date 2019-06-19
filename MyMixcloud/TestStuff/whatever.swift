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



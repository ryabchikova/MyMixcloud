//
//  FirstViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit





class FirstViewController: UIViewController {
    
    let service: UserService = UserServiceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbgUser()
        //dbgFollowingList()
        //dbgFollowing()
        print("in VC")
        
    }
    
    private func dbgUser() {
        service.user(userId: "elena-ryabchikova") { user, error in
            DispatchQueue.main.async {
                if let user = user {
                    print("SUCCESS")
                    print(user)
                }
                
                if let error = error {
                    print("FAIL")
                    print(error)
                    
                    if let mcerr = error as? MMError {
                        switch mcerr {
                        case .serverError(let description):
                            print(description)
                        default:
                            print()
                        }
                    }
                }
            }
        }
    }
    
    private func dbgFollowing() {
        
        service.following(userId: "elena-ryabchikova", page: 3) { users, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }

            if let users = users {
                print("Get \(users.count) following")
                users.forEach { print($0) }
            }
        }
    }
    
    private func dbgFollowingList() {
        
        service.followingList(userId: "elena-ryabchikova", page: 3) { list, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            
            if let list = list {
                print("Get \(list.count) following")
                print(list.joined(separator: ";"))
            }
        }
    }
}


//
//  FirstViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 14/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit



class FirstViewController: UIViewController {
    
    let service = UserServiceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RunLoop.current
        
        dbgFollowingUsers()
        print("in VC")
    }
    
    private func dbgUser() {
        service.user(identifier: "elena-ryabchikova", queue: DispatchQueue.global(qos: .userInitiated)) { user, error in
            DispatchQueue.main.async {
                if let user = user {
                    print("SUCCESS")
                    print(user)
                }
                
                if let error = error {
                    print("FAIL")
                    print(error)
                }
            }
        }
    }
    
    private func dbgFollowing() {
        service.following(identifier: "elena-ryabchikova", queue: DispatchQueue.global(qos: .userInitiated)) { following, error in
            DispatchQueue.main.async {
                if let following = following {
                    let next = following.nextPageUrl ?? "no"
                    print("following list: \(following.identifiers) next page: \(next)")
                }
                
                if let error = error {
                    print("FAIL")
                    print(error)
                }
            }
        }
    }
    
    private func dbgFollowingUsers() {
        service.following(identifier: "elena-ryabchikova", queue: DispatchQueue.global(qos: .userInitiated)) { [weak self]  following, _ in
            if let following = following {
                self?.service.usersSemaphore(identifiers: following.identifiers, queue: DispatchQueue.global(qos: .userInitiated)) { users, _ in
                    if let users = users {
                        for u in users {
                            print(u.name)
                        }
                    }
                }
            }
        }
    }
}


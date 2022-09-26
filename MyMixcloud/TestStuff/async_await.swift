//
//  async_await.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 01.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

/*
func following(userId: String, page: Int) async throws -> [User] {
    let followingList = try await followingList(userId: userId, page: page)
    
    guard !followingList.isEmpty else {
        // it's not error, just has no more items
        return []
    }
    
    // Nonthrowing variant: if get user fails, we skip it
    return await withTaskGroup(of: (Int, User)?.self) { group in
        for (index, userId) in followingList.enumerated() {
            group.addTask {
                guard let user = try? await self.user(userId: userId) else {
                    return nil
                }
                
                return (index, user)
            }
        }
        
        var users: [User?] = Array(repeating: nil, count: followingList.count)
        for await (index, user) in group.compactMap({ $0 }) {
            // use index to store User objects in the same order as input following list
            users[index] = user
        }
        
        return users.compactMap { $0 }
    }
}
 */

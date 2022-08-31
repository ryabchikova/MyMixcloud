//
//  UserServiveAsyncImpl.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 31.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

final class UserServiveAsyncImpl {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension UserServiveAsyncImpl: UserService {
    
    func user(userId: String, completionHandler: @escaping (User?, MMError?) -> Void) {
        completionHandler(nil, .noMatter)
    }
    func following(userId: String, page: Int, useCache permit: Bool, completionHandler: @escaping ([User]?, MMError?) -> Void) {
        completionHandler(nil, .noMatter)
    }
    
    func user(userId: String) async throws -> User {
        try Task.checkCancellation()
        guard let url = MixcloudApi.user.requestUrl(identifier: userId) else {
            throw MMError.executionError
        }
        
        let jsonUser: JsonUser = try await networkService.data(url: url)
        try Task.checkCancellation()
        
        return jsonUser.businessModel
    }
    
    func following(userId: String, page: Int) async throws -> [User] {
        let followingList = try await followingList(userId: userId, page: page)
        
        guard !followingList.isEmpty else {
            // it's not error, just has no more items
            return []
        }
        
        /*
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
         */
        
        // TODO: при ошибке в одном из тасков, исключение прокидывается выше, результат не возвращается
        return try await withThrowingTaskGroup(of: (Int, User).self) { group in
            for (index, userId) in followingList.enumerated() {
                group.addTask {
                    let user = try await self.user(userId: userId)
                    return (index, user)
                }
            }
            
            var users: [User?] = Array(repeating: nil, count: followingList.count)
            for try await (index, user) in group {
                // use index to store User objects in the same order as input following list
                users[index] = user
            }
            
            return users.compactMap { $0 }
        }
    }
    
}

private extension UserServiveAsyncImpl {
    
    private func followingList(userId: String, page: Int) async throws -> [String] {
        guard let url = MixcloudApi.following.requestUrl(identifier: userId, page: page) else {
            throw MMError.executionError
        }
        
        let jsonFollowing: JsonFollowing = try await networkService.data(url: url)
        return jsonFollowing.businessModel
    }
    
}

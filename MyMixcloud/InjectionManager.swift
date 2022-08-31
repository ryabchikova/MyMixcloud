//
//  InjectionManager.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 05/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import Swinject

final class InjectionManager {
    
    static let shared = InjectionManager()
    
    var resolver: Resolver {
        return container.synchronize()
    }
    
    private let container = Container()
    
    private init() {
        container.register(NetworkService.self) { resolver in
            NetworkServiceImpl(reachabilityService: resolver.resolve(NetworkReachabilityService.self)!)
        }
        
        container.register(UserService.self) { resolver in
            UserServiceImpl(reachabilityService: resolver.resolve(NetworkReachabilityService.self)!)
        }
        
        container.register(TrackService.self) { resolver in
            TrackServiceImpl(networkService: resolver.resolve(NetworkService.self)!)
        }
        
        container.register(SettingsService.self) { _ in
            SettingsServiceImpl()
        }

        container.register(NetworkReachabilityService.self) { _ in
            NetworkReachabilityServiceImpl()
        }
        
        container.register(AppRouter.self) { resolver in
            AppRouter(settingsService: resolver.resolve(SettingsService.self)!)
        }.inObjectScope(.container)
    }

}

extension InjectionManager {
    
    func networkService() -> NetworkService {
        return resolver.resolve(NetworkService.self)!
    }
    
    func userService() -> UserService {
        return resolver.resolve(UserService.self)!
    }
    
    func trackService() -> TrackService {
        return resolver.resolve(TrackService.self)!
    }
    
    func settingsService() -> SettingsService {
        return resolver.resolve(SettingsService.self)!
    }
    
    func networkReachabilityService() -> NetworkReachabilityService {
        return resolver.resolve(NetworkReachabilityService.self)!
    }
    
    func appRouter() -> AppRouter {
        return resolver.resolve(AppRouter.self)!
    }
}

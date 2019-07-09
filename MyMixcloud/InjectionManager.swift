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
        container.register(UserService.self) { _ in
            UserServiceImpl()
        }
        container.register(TrackService.self) { _ in
            TrackServiceImpl()
        }
        container.register(SettingsService.self) { _ in
            SettingsServiceImpl()
        }

        container.register(AppRouter.self) { resolver in
            AppRouter(settingsService: resolver.resolve(SettingsService.self)!)
        }.inObjectScope(.container)
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
    
    func appRouter() -> AppRouter {
        return resolver.resolve(AppRouter.self)!
    }
}

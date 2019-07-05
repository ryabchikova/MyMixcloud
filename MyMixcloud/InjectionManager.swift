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
    }
    
    // TODO подумать, интересно, но не понятны намерения в месте вызова
    //    func entity<T>() -> T {
    //        return resolver.resolve(T.self)!
    //    }
    
    func userService() -> UserService {
        return resolver.resolve(UserService.self)!
    }
    
    func trackService() -> TrackService {
        return resolver.resolve(TrackService.self)!
    }
}

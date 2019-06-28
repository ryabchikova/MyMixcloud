//
//  FollowingProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol FollowingModuleInput {
	var moduleOutput: FollowingModuleOutput? { get }
}

protocol FollowingModuleOutput: class {
}

protocol FollowingViewInput: class {
    func set(viewModels: [FollowingUserViewModel])
}

protocol FollowingViewOutput: class {
    func viewDidLoad()
}

protocol FollowingInteractorInput: class {
}

protocol FollowingInteractorOutput: class {
}

protocol FollowingRouterInput: class {
}

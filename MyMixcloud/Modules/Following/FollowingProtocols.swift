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
    func showDummyView()
}

protocol FollowingViewOutput: class {
    func viewDidLoad()
    func viewDidScrollPage()
}

protocol FollowingInteractorInput: class {
    func loadFollowing(userId: String, page: Int)
}

protocol FollowingInteractorOutput: class {
    func gotError(_ error: Error?)
    func didLoadFollowing(_ users: [User])
}

protocol FollowingRouterInput: class {
}

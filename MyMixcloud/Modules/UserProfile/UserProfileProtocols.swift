//
//  UserProfileProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol UserProfileModuleInput {
	var moduleOutput: UserProfileModuleOutput? { get }
}

protocol UserProfileModuleOutput: class {
}

protocol UserProfileViewInput: class {
    func set(userProfileViewModel: UserProfileViewModel)
    func showDummyView()
}

protocol UserProfileViewOutput: class {
    func viewDidLoad()
}

protocol UserProfileInteractorInput: class {
    func loadUser(userId: String)
}

protocol UserProfileInteractorOutput: class {
    func gotError(_ error: Error?)
    func didLoadUser(_ user: User)
}

protocol UserProfileRouterInput: class {
}

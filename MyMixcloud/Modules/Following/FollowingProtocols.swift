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
}

protocol FollowingViewOutput: class {
}

protocol FollowingInteractorInput: class {
}

protocol FollowingInteractorOutput: class {
}

protocol FollowingRouterInput: class {
}

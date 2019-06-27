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
}

protocol UserProfileViewOutput: class {
}

protocol UserProfileInteractorInput: class {
}

protocol UserProfileInteractorOutput: class {
}

protocol UserProfileRouterInput: class {
}

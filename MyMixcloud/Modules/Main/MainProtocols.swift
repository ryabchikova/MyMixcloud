//
//  MainProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: class {
    func didLogout()
}

protocol MainViewInput: class {
}

protocol MainViewOutput: class {
}

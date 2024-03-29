//
//  LoginProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

// MARK: - Module
protocol LoginModuleInput: AnyObject {}

protocol LoginModuleOutput: AnyObject {
    func didLogin()
}

// MARK: - View
protocol LoginViewInput: AnyObject {
    func set(viewModel: LoginViewModel)
}

protocol LoginViewOutput: AnyObject {
    func viewDidLoad()
}

// MARK: - Interactor
protocol LoginInteractorInput {
    func login(with username: String)
}

protocol LoginInteractorOutput: AnyObject {
    func didLogin() async
    func loginFailed() async
}

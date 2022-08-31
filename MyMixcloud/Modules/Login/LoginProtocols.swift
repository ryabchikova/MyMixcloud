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
protocol LoginViewInput: AnyObject {}

protocol LoginViewOutput: AnyObject {
    func didTapStart(with username: String)
}

// MARK: - Interactor
protocol LoginInteractorInput {
    func login(with username: String)
}

@MainActor
protocol LoginInteractorOutput: AnyObject {
    func didLogin()
    func loginFailed()
}

// MARK: - Router
protocol LoginRouterInput {
    func showErrorAlert(in viewController: UIViewController)
}

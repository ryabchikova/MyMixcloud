//
//  LoginProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol LoginModuleInput {
	var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: class {
}

protocol LoginViewInput: class {
}

protocol LoginViewOutput: class {
    func didTapStart(with username: String)
}

protocol LoginInteractorInput: class {
    func login(with username: String)
}

protocol LoginInteractorOutput: class {
    func didLogin()
    func loginFailed(reason: LoginErrorReason)
}

protocol LoginRouterInput: class {
    func showLoginErrorAlert(in viewController: UIViewController)
    func showServiceErrorAlert(in viewController: UIViewController)
}

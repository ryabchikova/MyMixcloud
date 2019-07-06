//
//  LoginInteractor.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

enum LoginErrorReason {
    case userNotFound
    case webServiceError
}

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func login(with username: String) {
        // TODO try to get user
        
        output?.loginFailed(reason: .userNotFound)
    }
}

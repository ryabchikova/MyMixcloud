//
//  LoginViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

// TODO fix text choppy when tap on textfield

final class LoginViewController: UIViewController {
	private let output: LoginViewOutput
    private let loginView = LoginView()

    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(loginView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MMColors.white
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.pin.all(view.pin.safeArea)
    }
}

extension LoginViewController: LoginViewInput {
    func set(viewModel: LoginViewModel) {
        loginView.setup(with: viewModel)
    }
}

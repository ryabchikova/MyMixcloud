//
//  UserProfileViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit
import PinLayout

final class UserProfileViewController: UIViewController {
    private let output: UserProfileViewOutput
    private let profileView = UserProfileView()
    
    init(output: UserProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "User profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: .plain, target: self, action: #selector(didTapSettings))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(profileView)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = MMColors.white
	}
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView.pin.all(view.pin.safeArea)
    }
    
    @objc private func didTapSettings() {
        output.didTapSettingsButton()
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func set(userProfileViewModel: UserProfileViewModel) {
        self.profileView.update(with: userProfileViewModel)
    }
    
    func showDummyView() {
    }
}

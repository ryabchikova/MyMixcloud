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
    private let scrollView = UIScrollView()
    private let profileView = UserProfileView()
    
    init(output: UserProfileViewOutput, isMyProfile: Bool) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
        if isMyProfile {
            navigationItem.title = "User profile"
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(didTapSettings))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        scrollView.addSubview(profileView)
        view.addSubview(scrollView)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = MMColors.white
        scrollView.backgroundColor = MMColors.white
        scrollView.bounces = false
	}
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.pin.all(view.pin.safeArea)
        profileView.pin.top().left().right()
        profileView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = profileView.frame.size
    }
    
    @objc private func didTapSettings() {
        output.didTapSettingsButton()
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func set(userProfileViewModel: UserProfileViewModel) {
        self.profileView.update(with: userProfileViewModel)
        view.setNeedsLayout()
    }
    
    func showDummyView() {
    }
}

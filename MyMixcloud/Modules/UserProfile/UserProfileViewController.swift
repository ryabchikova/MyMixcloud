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
        output.viewDidLoad()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO в константы/привязка к safe areas/ еще что-то
        profileView.pin.horizontally(10.0).top(200.0).bottom(20.0)
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func set(userProfileViewModel: UserProfileViewModel) {
        DispatchQueue.main.async {
            self.profileView.update(with: userProfileViewModel)
        }
    }
    
    func showDummyView() {
        DispatchQueue.main.async {
            let dummy = DummyView(frame: self.view.frame)
            self.view.addSubview(dummy)
        }
    }
}

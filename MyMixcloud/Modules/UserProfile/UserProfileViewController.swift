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
        view.backgroundColor = MMColors.white
        self.view.addSubview(profileView)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
//        let user = User(identifier: "123",
//                        name: "Elena Ryabchikova",
//                        country: "Russia",
//                        city: "Istra",
//                        bio: "I'm skater, music lower & iOS-developer :)",
//                        favoritesCount: 22,
//                        followersCount: 13,
//                        followingCount: 21,
//                        profileImage: URL(string: "https://thumbnailer.mixcloud.com/unsafe/300x300/profile/7/9/a/3/ae6e-476e-4896-9120-3982e86ec02f"))
//        profileView.update(with: UserProfileViewModel(user: user))
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO в константы/привязка к safe areas/ еще что-то
        profileView.pin.horizontally(10.0).top(200.0).bottom(20.0)
    }
}

extension UserProfileViewController: UserProfileViewInput {
}

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
    //private var dummyView: DummyView?

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
	}
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView.pin.all()
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func set(userProfileViewModel: UserProfileViewModel) {
//            if let dummyView = self.dummyView {
//                dummyView.removeFromSuperview()
//                self.dummyView = nil     // TODO не надо???
//            }
        self.profileView.update(with: userProfileViewModel)
    }
    
    func showDummyView() {
//            guard self.dummyView == nil else {
//                return
//            }
//            let dummy = DummyView(frame: self.view.frame)
//            self.view.addSubview(dummy)
//            self.dummyView = dummy
    }
}

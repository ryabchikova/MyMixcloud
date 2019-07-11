//
//  TrackViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackViewController: UIViewController {
	private let output: TrackViewOutput
    private let trackView = TrackView()

    init(output: TrackViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(trackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MMColors.white
        output.viewDidLoad()
    }
    
    // TODO контент может не влезть !!!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trackView.pin.all(view.pin.safeArea)
    }
}

extension TrackViewController: TrackViewInput {
    func set(trackViewModel: TrackViewModel) {
        self.trackView.update(with: trackViewModel)
    }
}

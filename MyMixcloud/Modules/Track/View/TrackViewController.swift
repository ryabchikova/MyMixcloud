//
//  TrackViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackViewController: MMViewController {
	private let output: TrackViewOutput
    private let scrollView = UIScrollView()
    private let trackView = TrackView()

    init(output: TrackViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        scrollView.addSubview(trackView)
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MMColors.white
        scrollView.backgroundColor = MMColors.white
        setupPullToRefresh(in: scrollView) { [weak self] in
            self?.output.didPullToRefresh()
        }
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.pin.all(view.pin.safeArea)
        trackView.pin.top().left().right()
        trackView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = trackView.frame.size
    }
}

extension TrackViewController: EmptyCheck {
    var isEmpty: Bool {
        return trackView.isEmpty
    }
}

extension TrackViewController: TrackViewInput {
    func set(trackViewModel: TrackViewModel) {
        trackView.update(with: trackViewModel)
        view.setNeedsLayout()
    }
}

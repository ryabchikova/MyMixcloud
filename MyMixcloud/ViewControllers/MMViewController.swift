//
//  MMViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 15/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit
import PinLayout

class MMViewController: UIViewController {
    private var dummyView: DummyView?
    private weak var scrollView: UIScrollView?
    private var refreshControl: UIRefreshControl?
    private var didPullToRefresh: (() -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dummyView?.pin.all(view.pin.safeArea)
    }
    
    // MARK: - Dummy View
    
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void) {
        hideDummyViewIfNeed()
        dummyView = DummyView(model: DummyViewModel(error: error), retryHandler: retryHandler)
        view.addSubview(dummyView!)
    }
    
    func hideDummyViewIfNeed() {
        guard let dummy = dummyView else {
            return
        }
        dummy.removeFromSuperview()
        dummyView = nil
    }
    
    // MARK: - Pull To Refresh
    
    func setupPullToRefresh(in scrollView: UIScrollView, pullToRefreshCompletion: @escaping (() -> Void)) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        } else {
            scrollView.addSubview(refreshControl)
        }
        
        self.scrollView = scrollView
        self.refreshControl = refreshControl
        self.didPullToRefresh = pullToRefreshCompletion
    }
    
    @objc private func handlePullToRefresh() {
        didPullToRefresh?()
        refreshControl?.endRefreshing()
    }
}

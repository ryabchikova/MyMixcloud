//
//  MMViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 15/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

class MMViewController: UIViewController {
    private var dummyView: DummyView?
    private weak var scrollView: UIScrollView?
    private var refreshControl: UIRefreshControl?
    private var didPullToRefresh: (() -> Void)?
    private var activityIndicator: UIActivityIndicatorView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dummyView?.pin.all(view.pin.safeArea)
        activityIndicator?.pin.center(to: view.anchor.center)
    }
    
    // MARK: - Pull To Refresh
    
    func setupPullToRefresh(in scrollView: UIScrollView, pullToRefreshCompletion: @escaping (() -> Void)) {
        guard refreshControl == nil else {
            return
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Styles.loadingIndicatorColor
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
    
    // MARK: - Activity Indicator
    
    func setupActivityIndicator() {
        guard activityIndicator == nil else {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = Styles.loadingIndicatorColor
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
    }
    
    func showActivity() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }

    func hideActivity() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
}

extension MMViewController: DummyViewDisplayable {    
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
}

private extension MMViewController {
    enum Styles {
        static let loadingIndicatorColor = MMColors.darkGray
    }
}


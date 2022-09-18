//
//  FollowingViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class FollowingViewController: MMViewController {
	private let output: FollowingViewOutput
    private let tableView = UITableView()
    private let tableViewManager = TableViewManager<FollowingUserViewModel, FollowingTableViewCell>()

    init(output: FollowingViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Following"
        
        tableViewManager.didScrollPage = { [weak self] in
            self?.output.viewDidScrollPage()
        }
        tableViewManager.didSelectItemWithId = { [weak self] id in
            self?.output.didTapOnUser(with: id)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MMColors.white
        tableViewManager.configure(tableView: tableView)
        setupPullToRefresh(in: tableView) { [weak self] in
            self?.output.didPullToRefresh()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }
    
    // TODO: перенести viewWillLayoutSubviews() везде
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
}

extension FollowingViewController: EmptyCheckTrait {
    var isEmpty: Bool { tableViewManager.isEmpty }
}

extension FollowingViewController: FollowingViewInput {
    func set(viewModels: [FollowingUserViewModel]) {
        tableViewManager.set(viewModels: viewModels)
    }
    
    func reset(viewModels: [FollowingUserViewModel]) {
        tableViewManager.reset(viewModels: viewModels)
    }
}

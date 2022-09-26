//
//  TrackListViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackListViewController: MMViewController {
	private let output: TrackListViewOutput
    private let tableView = UITableView()
    private let tableViewManager = TableViewManager<TrackListItemViewModel, TrackListTableViewCell>()

    init(output: TrackListViewOutput, title: String) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        
        tableViewManager.didScrollPage = { [weak self] in
            self?.output.viewDidScrollPage()
        }
        tableViewManager.didSelectItemWithId = { [weak self] id in
            self?.output.didTapOnTrack(with: id)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
}

extension TrackListViewController: EmptyCheckTrait {
    var isEmpty: Bool { tableViewManager.isEmpty }
}

extension TrackListViewController: TrackListViewInput {
    func set(viewModels: [TrackListItemViewModel]) {
        tableViewManager.set(viewModels: viewModels)
    }
    
    func reset(viewModels: [TrackListItemViewModel]) {
        tableViewManager.reset(viewModels: viewModels)
    }
}

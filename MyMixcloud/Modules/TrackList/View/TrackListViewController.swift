//
//  TrackListViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackListViewController: UIViewController {
	private let output: TrackListViewOutput
    private let tableView = UITableView()
    private let tableViewManager = {
        TableViewManager<TrackListItemViewModel, TrackListTableViewCell>(cellReuseIdentifier: String(describing: TrackListTableViewCell.self))
    }()

    init(output: TrackListViewOutput, title: String) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        
        tableViewManager.didScrollPage = { [weak self] in
            self?.output.viewDidScrollPage()
        }
        tableViewManager.didSelectItemWithId = { [weak self] trackId in
            self?.output.didTapOnTrack(with: trackId)
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
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
}

extension TrackListViewController: TrackListViewInput {
    func set(viewModels: [TrackListItemViewModel]) {
        tableViewManager.set(viewModels: viewModels)
    }
}

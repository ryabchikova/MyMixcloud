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
    private var models: [TrackListItemViewModel] = []

    init(output: TrackListViewOutput, title: String) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        setupTableView()
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
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(TrackListTableViewCell.self,
                           forCellReuseIdentifier: String(describing: TrackListTableViewCell.self))
        tableView.rowHeight = TrackListTableViewCell.height
        tableView.separatorInset.left = Constants.tableViewSeparatorInset
        tableView.separatorInset.right = Constants.tableViewSeparatorInset
    }
}

extension TrackListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: TrackListTableViewCell.self),
                                                  for: indexPath) as! TrackListTableViewCell
        cell.update(with: models[indexPath.row])
        return cell
    }
}

extension TrackListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.height
        let distanceToBottom = scrollView.contentSize.height - scrollView.contentOffset.y - pageHeight
        
        if distanceToBottom < 0.2 * pageHeight {
            output.viewDidScrollPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.viewDidTapOnTrack(with: models[indexPath.row].trackId)
    }
}

extension TrackListViewController: TrackListViewInput {
    
    func set(viewModels: [TrackListItemViewModel]) {
        models.append(contentsOf: viewModels)
        self.tableView.reloadData()
    }
    
    func showDummyView() {
        
        // TODO его нужно как-то скывать вообще-то и remove from superview
        
//        guard models.isEmpty else {
//            return
//        }
//
//            let dummy = DummyView()
//            self.view.addSubview(dummy)
    }
}

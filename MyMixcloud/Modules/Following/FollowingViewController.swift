//
//  FollowingViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class FollowingViewController: UIViewController {
	private let output: FollowingViewOutput
    
    private let tableView = UITableView()
    private var models: [FollowingUserViewModel] = []

    init(output: FollowingViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
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
        tableView.register(FollowingTableViewCell.self,
                           forCellReuseIdentifier: String(describing: FollowingTableViewCell.self))
        tableView.rowHeight = FollowingTableViewCell.height
        tableView.separatorInset.left = Constants.tableViewSeparatorInset
        tableView.separatorInset.right = Constants.tableViewSeparatorInset
    }
}

extension FollowingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: FollowingTableViewCell.self),
                                                  for: indexPath) as! FollowingTableViewCell
        cell.update(with: models[indexPath.row])
        return cell
    }
}

extension FollowingViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.height
        let distanceToBottom = scrollView.contentSize.height - scrollView.contentOffset.y - pageHeight
        
        if distanceToBottom < 0.2 * pageHeight {
            output.viewDidScrollPage()
        }
    }
}

extension FollowingViewController: FollowingViewInput {
    
    func set(viewModels: [FollowingUserViewModel]) {
        models.append(contentsOf: viewModels)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showDummyView() {
        
        // TODO его нужно как-то скывать вообще-то и remove from superview
        
        guard models.isEmpty else {
            return
        }
        
        DispatchQueue.main.async {
            let dummy = DummyView(frame: self.view.frame)
            self.view.addSubview(dummy)
        }
    }
}

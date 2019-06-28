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
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = MMColors.white
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(FollowingTableViewCell.self, forCellReuseIdentifier: String(describing: FollowingTableViewCell.self))
        tableView.rowHeight = FollowingTableViewCell.height
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
}

extension FollowingViewController: FollowingViewInput {
    func set(viewModels: [FollowingUserViewModel]) {
        models = viewModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

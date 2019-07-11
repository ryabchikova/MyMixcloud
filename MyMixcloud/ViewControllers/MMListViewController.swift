//
//  MMListViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 10/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

//final class MMTableViewCell<Model>: UITableViewCell {
//    func update(with model: Model)
//}
//
//final class MMListViewController<Model, Cell: MMTableViewCell>: UIViewController {
//    private let tableView = UITableView()
//    private var models: [Model] = []
//    
//    init(output: FollowingViewOutput) {
//        super.init(nibName: nil, bundle: nil)
//        setupTableView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func loadView() {
//        self.view = UIView()
//        view.addSubview(tableView)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = MMColors.white
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.pin.all(view.pin.safeArea)
//    }
//    
//    private func setupTableView() {
//        tableView.dataSource = self
//        //tableView.delegate = self
//        tableView.tableFooterView = UIView()
//        tableView.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
//        tableView.separatorInset.left = Constants.tableViewSeparatorInset
//        tableView.separatorInset.right = Constants.tableViewSeparatorInset
//    }
//    
//    // MARK: UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! MMTableViewCell
//        ce
//        //cell.update(with: models[indexPath.row])
//        return cell
//    }
//}

//extension MMListViewController: UITableViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageHeight = scrollView.frame.height
//        let distanceToBottom = scrollView.contentSize.height - scrollView.contentOffset.y - pageHeight
//
//        if distanceToBottom < 0.2 * pageHeight {
//            output.viewDidScrollPage()
//        }
//    }
//}

//extension FollowingViewController: FollowingViewInput {
//
//    func set(viewModels: [FollowingUserViewModel]) {
//        models.append(contentsOf: viewModels)
//        self.tableView.reloadData()
//    }
//}

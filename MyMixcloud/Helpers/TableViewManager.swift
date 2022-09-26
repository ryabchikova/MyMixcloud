//
//  TableViewManager.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 15/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

typealias TableViewCell = UITableViewCell & ConfigurableView & FixedHeightView

final class TableViewManager<Model: Identifiable, Cell: TableViewCell>:
    NSObject, UITableViewDataSource, UITableViewDelegate
    where Cell.Model == Model {
    
    var didScrollPage: (() -> Void)?
    var didSelectItemWithId: ((Model.ID) -> Void)?
    
    private weak var tableView: UITableView?
    private var models: [Model] = []
    private var cellReuseIdentifier: String {
        String(describing: Cell.self)
    }
    
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(Cell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = Cell.height
        tableView.separatorInset.left = Constants.tableViewSeparatorInset
        tableView.separatorInset.right = Constants.tableViewSeparatorInset
        self.tableView = tableView
    }
    
    func set(viewModels: [Model]) {
        models.append(contentsOf: viewModels)
        tableView?.reloadData()
    }
    
    func reset(viewModels: [Model]) {
        models = viewModels
        tableView?.reloadData()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! Cell
        cell.configure(with: models[indexPath.row] )
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.height
        let distanceToBottom = scrollView.contentSize.height - scrollView.contentOffset.y - pageHeight
        
        if distanceToBottom < 0.2 * pageHeight {
            didScrollPage?()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemWithId?(models[indexPath.row].id)
    }
}

extension TableViewManager: EmptyCheckTrait {
    var isEmpty: Bool { models.isEmpty }
}

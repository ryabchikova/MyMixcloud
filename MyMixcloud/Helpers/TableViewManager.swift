//
//  TableViewManager.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 15/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit


final class TableViewManager<Model: Identifiable, Cell: UITableViewCell & MMTableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell.T == Model {
    
    var tableIsEmpty: Bool {
        return models.isEmpty
    }
    
    var didScrollPage: (() -> Void)?
    var didSelectItemWithId: ((String) -> Void)?
    
    private weak var tableView: UITableView?
    private let cellReuseIdentifier: String
    private var models: [Model] = []
    
    init(cellReuseIdentifier: String) {
        self.cellReuseIdentifier = cellReuseIdentifier
    }
    
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(Cell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! Cell
        cell.update(with: models[indexPath.row] )
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
        didSelectItemWithId?(models[indexPath.row].identifier)
    }
}

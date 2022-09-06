//
//  SettingsViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit


final class SettingsViewController: UIViewController {
	private let output: SettingsViewOutput
    private let tableView = UITableView()
    private let tableViewManager = {
        TableViewManager<SettingsViewModel, SettingsTableViewCell>(
            cellReuseIdentifier: String(describing: SettingsTableViewCell.self)
        )
    }()

    init(output: SettingsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Settings"
        
        tableViewManager.didSelectItemWithId = { [weak self] itemId in
            self?.output.didSelectItem(itemId)
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

extension SettingsViewController: SettingsViewInput {
    func set(viewModels: [SettingsViewModel]) {
        tableViewManager.set(viewModels: viewModels)
    }
}

//
//  SettingsViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 08/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

enum SettingsItem {
    case logout
    case theme
    
    var title: NSAttributedString {
        switch self {
        case .logout:
            return NSAttributedString(string: "Log out", attributes: SettingsItem.titleAttributes)
        case .theme:
            return NSAttributedString(string: "Theme", attributes: SettingsItem.titleDisabledAttributes)
        }
    }
    
    private static let titleAttributes: [NSAttributedString.Key : Any] = [.font: MMFonts.mediumBold,
                                                                          .foregroundColor: MMColors.darkGray]
    private static let titleDisabledAttributes: [NSAttributedString.Key : Any] = [.font: MMFonts.medium,
                                                                          .foregroundColor: MMColors.lightGray]
}

// TODO can use TableViewManager
// TODO custom table view cell

final class SettingsViewController: UIViewController {
	private let output: SettingsViewOutput
    private let tableView = UITableView()
    private let items: [SettingsItem]

    init(output: SettingsViewOutput) {
        self.output = output
        self.items = [.logout, .theme]
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Settings"
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
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.separatorInset.left = Constants.tableViewSeparatorInset
        tableView.separatorInset.right = Constants.tableViewSeparatorInset
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.attributedText = items[indexPath.row].title
        cell.selectionStyle = .none
        if items[indexPath.row] == .theme {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectItem(items[indexPath.row])
    }
}

extension SettingsViewController: SettingsViewInput {
}

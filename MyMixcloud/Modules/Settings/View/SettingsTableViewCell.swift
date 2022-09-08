//
//  SettingsTableViewCell.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {}

extension SettingsTableViewCell: FixedHeightView {
    static let height: CGFloat = 40.0
}

extension SettingsTableViewCell: ConfigurableView {
    func configure(with model: SettingsViewModel) {
        textLabel?.attributedText = model.title
        isUserInteractionEnabled = model.isEnabled
    }
}

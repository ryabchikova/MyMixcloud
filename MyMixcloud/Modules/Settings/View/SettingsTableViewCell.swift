//
//  SettingsTableViewCell.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    private var switcher = UISwitch()
    private var onSwitch: ((Bool) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        switcher.removeTarget(self, action: #selector(didToggleSwitcher), for: .valueChanged)
    }

    @objc
    private func didToggleSwitcher() {
        onSwitch?(switcher.isOn)
    }
}

extension SettingsTableViewCell: FixedHeightView {
    static let height: CGFloat = 40.0
}

extension SettingsTableViewCell: ConfigurableView {
    func configure(with model: SettingsViewModel) {
        textLabel?.attributedText = model.title
        isUserInteractionEnabled = model.isEnabled
        onSwitch = model.onSwitch
        
        if model.shouldShowAccessoryView {
            accessoryView = switcher
            switcher.isOn = model.isSwitcherOn
            switcher.addTarget(self, action: #selector(didToggleSwitcher), for: .valueChanged)
        } else {
            accessoryView = nil
        }
    }
}

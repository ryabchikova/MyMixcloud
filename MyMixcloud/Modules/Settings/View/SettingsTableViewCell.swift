//
//  SettingsTableViewCell.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell, MMTableViewCell {
    static let height: CGFloat = 40.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: SettingsViewModel) {
        textLabel?.attributedText = model.title
        isUserInteractionEnabled = model.isEnabled
    }
}

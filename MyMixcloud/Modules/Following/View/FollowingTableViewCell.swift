//
//  FollowingTableViewCell.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit
import PinLayout

final class FollowingTableViewCell: UITableViewCell {
    
    static let height = CGFloat(76.0)
    private let userView = FollowingUserView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //selectionStyle = .none
        contentView.addSubview(userView)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userView.pin.all()
    }
    
    func update(with model: FollowingUserViewModel) {
        userView.update(with: model)
    }
}

//
//  TrackListTableViewCell.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import PinLayout

final class TrackListTableViewCell: UITableViewCell {
    private let itemView = TrackListItemView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(itemView)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        itemView.pin.all()
    }
}

extension TrackListTableViewCell: FixedHeightView {
    static let height: CGFloat = 92.0
}

extension TrackListTableViewCell: ConfigurableView {
    func configure(with model: TrackListItemViewModel) {
        itemView.configure(with: model)
    }
}

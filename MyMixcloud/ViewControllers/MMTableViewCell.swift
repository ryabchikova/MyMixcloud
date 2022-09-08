//
//  MMTableViewCell.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 08.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import PinLayout

final class MMTableViewCell<View: UIView & ConfigurableView>: UITableViewCell {
    private let rootView: View
    
    init(reuseIdentifier: String?, rootView: View) {
        self.rootView = rootView
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rootView)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all()
    }
}

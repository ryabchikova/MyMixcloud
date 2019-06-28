//
//  DummyView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import PinLayout

final class DummyView: UIView {
    
    private let errorMessageLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = Styles.backgroundColor
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.attributedText = NSAttributedString(string: "An error has occurred. Retry the request later.", attributes: Styles.message)
        errorMessageLabel.textAlignment = .center
        addSubview(errorMessageLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        errorMessageLabel.pin.all(Constants.messageMargin)
    }
}

extension DummyView {
    
    private struct Constants {
        static let messageMargin: CGFloat = 10.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
        
        static let message: [NSAttributedString.Key: Any] = {
            return [
                .font: MMFonts.mediumBold,
                .foregroundColor: MMColors.darkGray
            ]
        }()
    }
}

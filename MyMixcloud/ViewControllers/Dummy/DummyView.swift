//
//  DummyView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


import Foundation
import FlexLayout

final class DummyView: UIView {
    private let errorMessageLabel = UILabel()
    private let retryButton = UIButton(type: .custom)
    private let retryHandler: () -> Void
    
    init(model: DummyViewModel, retryHandler: @escaping () -> Void) {
        self.retryHandler = retryHandler
        super.init(frame: .zero)
        createFlex()
        setup(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.layout(mode: .fitContainer)
    }
    
    private func setup(with model: DummyViewModel) {
        backgroundColor = Styles.backgroundColor
        
        errorMessageLabel.backgroundColor = Styles.backgroundColor
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.attributedText = model.errorMessageString
        errorMessageLabel.flex.markDirty()
        
        retryButton.backgroundColor = Styles.buttonColor
        retryButton.layer.cornerRadius = Constants.cornerRadius
        retryButton.layer.masksToBounds = true
        retryButton.isEnabled = true
        retryButton.setAttributedTitle(model.retryButtonTitleString, for: .normal)
        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
    
        setNeedsLayout()
    }
    
    private func createFlex() {
        flex.addItem()
            .direction(.column)
            .width(100%)
            .height(100%)
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(errorMessageLabel)
                    .marginHorizontal(Constants.messageMargin)
        
                flex.addItem(retryButton)
                    .width(Constants.buttonWidth)
                    .height(Constants.buttonHeight)
                    .marginTop(Constants.buttonTopMargin)
        }
    }
    
    @objc private func retryButtonPressed() {
        retryHandler()
    }
}

extension DummyView {
    
    private struct Constants {
        static let messageMargin: CGFloat = 20.0
        static let cornerRadius: CGFloat = 4.0
        static let buttonWidth: CGFloat = 140.0
        static let buttonHeight: CGFloat = 40.0
        static let buttonTopMargin: CGFloat = 30.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
        static let buttonColor = MMColors.sunny
    }
}


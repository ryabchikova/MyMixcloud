//
//  LoginView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import FlexLayout

// TODO fix placeholder text choppy when tap on textfield

final class LoginView: UIView {
    weak var output: LoginViewOutput?
    private let welcomeLabel = UILabel()
    private let userNameTextField = UITextField()
    private let startButton = UIButton(type: .custom)
    
    init(model: LoginViewModel) {
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
    
    private func setup(with model: LoginViewModel) {
        backgroundColor = Styles.backgroundColor
    
        welcomeLabel.backgroundColor = Styles.backgroundColor
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.attributedText = model.welcomeString
        welcomeLabel.flex.markDirty()
        
        userNameTextField.backgroundColor = Styles.textFieldColor
        userNameTextField.layer.cornerRadius = Constants.cornerRadius
        userNameTextField.layer.masksToBounds = true
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.font = Styles.userNameFont
        userNameTextField.textColor = Styles.userNameColor
        userNameTextField.textAlignment = .center
        userNameTextField.adjustsFontSizeToFitWidth = true
        userNameTextField.autocapitalizationType = .none
        userNameTextField.autocorrectionType = .no
        userNameTextField.returnKeyType = .done
        userNameTextField.delegate = self
        
        startButton.backgroundColor = Styles.buttonColor
        startButton.layer.cornerRadius = Constants.cornerRadius
        startButton.layer.masksToBounds = true
        startButton.isEnabled = false
        startButton.setAttributedTitle(model.startButtonEnabledString, for: .normal)
        startButton.setAttributedTitle(model.startButtonDisabledString, for: .disabled)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
        setNeedsLayout()
    }
    
    private func createFlex() {
        flex.addItem()
            .direction(.column)
            .width(100%)
            .height(100%)
            .justifyContent(.center)
            .define { flex in
                flex.addItem()
                    .direction(.column)
                    .marginHorizontal(Constants.contentHorizontalMargin)
                    .define { flex in
                        flex.addItem(welcomeLabel)
                            .width(100%)
                        
                        flex.addItem(userNameTextField)
                            .width(100%)
                            .height(Constants.textFieldHeight)
                            .marginTop(Constants.topMargin)
                        
                        flex.addItem(startButton)
                            .width(100%)
                            .height(Constants.startButtonHeight)
                            .marginTop(Constants.topMargin)
                    }
            }
    }
    
    @objc private func startButtonPressed() {
        output?.didTapStart(with: userNameTextField.text ?? "")
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        startButton.isEnabled = !(textField.text ?? "").isEmpty
        return true
    }
}

extension LoginView {
    
    private struct Constants {
        static let contentHorizontalMargin: CGFloat = 40.0
        static let textFieldHeight: CGFloat = 40.0
        static let startButtonHeight: CGFloat = 40.0
        static let cornerRadius: CGFloat = 4.0
        static let topMargin: CGFloat = 30.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
        static let textFieldColor = MMColors.superLightGray
        static let buttonColor = MMColors.sunny
        static let userNameColor = MMColors.darkGray
        static let userNameFont = MMFonts.mediumBold
    }
}


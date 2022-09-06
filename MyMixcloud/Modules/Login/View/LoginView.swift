//
//  LoginView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 06/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import FlexLayout

// TODO: Start is Enabled when textfield not Empty

final class LoginView: UIView {
    private let welcomeLabel = UILabel()
    private let userNameTextField = UITextField()
    private let startButton = UIButton(type: .custom)
    private var onButtonTap: ((String) -> Void)?
    
    init() {
        super.init(frame: .zero)
        createFlex()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.layout(mode: .fitContainer)
    }
    
    func setup(with model: LoginViewModel) {
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
        startButton.setAttributedTitle(model.startButtonString(for: .normal), for: .normal)
        startButton.setAttributedTitle(model.startButtonString(for: .disabled), for: .disabled)
        startButton.setAttributedTitle(model.startButtonString(for: .highlited), for: .highlighted)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        onButtonTap = model.onButtonTap
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOutsideKeyboard)))
        
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
        guard let text = userNameTextField.text else {
            return
        }
        
        onButtonTap?(text)
    }
    
    @objc private func didTapOutsideKeyboard() {
        userNameTextField.resignFirstResponder()
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


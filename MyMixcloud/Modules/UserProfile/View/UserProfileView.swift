//
//  UserProfileView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import FlexLayout
import SDWebImage

// TODO + cover picture

final class UserProfileView: UIView {
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationImageView = UIImageView()
    private let locationLabel = UILabel()
    private let bioLabel = UILabel()
    private let followersLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setup()
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
    
    private func setup() {
        backgroundColor = Styles.backgroundColor
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = MMColors.placeholder
        avatarImageView.layer.borderColor = MMColors.white.cgColor
        avatarImageView.layer.borderWidth = Constants.borderWidth
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        avatarImageView.layer.masksToBounds = true
        
        nameLabel.backgroundColor = Styles.backgroundColor
        
        locationImageView.image = UIImage(named: "locationIcon")
        locationImageView.contentMode = .scaleAspectFit
        locationLabel.backgroundColor = Styles.backgroundColor
        
        bioLabel.backgroundColor = Styles.backgroundColor
        bioLabel.numberOfLines = 0
        
        followersLabel.backgroundColor = Styles.backgroundColor
    }
    
    private func createFlex() {
        
        flex.addItem()
            .direction(.column)
            .width(100%)
            .height(100%)
            .alignItems(.center).define { flex in
                flex.addItem(avatarImageView)
                    .size(Constants.avatarImageSize)
                
                flex.addItem(nameLabel)
                    .marginTop(Constants.nameTopMargin)
                    .shrink(1)
                

                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .marginTop(Constants.locationTopMargin)
                    .shrink(1).define { flex in
                        flex.addItem(locationImageView)
                            .size(Constants.locationImageSize)
                        flex.addItem(locationLabel)
                            .marginLeft(Constants.locationLeftMargin)
                            .shrink(1)
                    }
                
                flex.addItem(bioLabel)
                    .marginTop(Constants.bioTopMargin)
                    .shrink(1)
                
                flex.addItem(followersLabel)
                    .marginTop(Constants.followersTopMargin)
                    .shrink(1)
                    .alignSelf(.start)
            }
    }
    
    func update(with model: UserProfileViewModel) {
        avatarImageView.sd_setImage(with: model.avatarImageUrl)
        
        nameLabel.attributedText = model.nameString
        nameLabel.flex.markDirty()
        
        locationLabel.attributedText = model.locationString
        locationLabel.flex.display(model.locationString != nil ? .flex : .none)
        locationLabel.flex.markDirty()
        
        bioLabel.attributedText = model.bioString
        bioLabel.flex.display(model.bioString != nil ? .flex : .none)
        bioLabel.flex.markDirty()
        
        followersLabel.attributedText = model.followersString
        followersLabel.flex.display(model.followersString != nil ? .flex : .none)
        followersLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

extension UserProfileView {
    
    private struct Constants {
        static let avatarImageSize: CGFloat = 200.0
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 20.0
        static let locationImageSize: CGFloat = 22.0
        static let locationLeftMargin: CGFloat = 10.0
        static let nameTopMargin: CGFloat = 10.0
        static let locationTopMargin: CGFloat = 10.0
        static let bioTopMargin: CGFloat = 30.0
        static let followersTopMargin: CGFloat = 10.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
    }
}

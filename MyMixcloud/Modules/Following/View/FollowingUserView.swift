//
//  FollowingUserView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//
import Foundation
import FlexLayout
import SDWebImage

final class FollowingUserView: UIView {
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
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
        avatarImageView.backgroundColor = MMColors.imagePlaceholder
        avatarImageView.layer.borderColor = Styles.borderColor.cgColor
        avatarImageView.layer.borderWidth = Constants.borderWidth
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        avatarImageView.layer.masksToBounds = true
        
        nameLabel.backgroundColor = Styles.backgroundColor
        locationLabel.backgroundColor = Styles.backgroundColor
        followersLabel.backgroundColor = Styles.backgroundColor
    }
    
    private func createFlex() {
        flex.addItem()
            .direction(.row)
            .width(100%)
            .height(100%)
            .alignItems(.center)
            .define { flex in
                flex.addItem(avatarImageView)
                    .size(Constants.avatarSize)
                    .margin(Constants.outerMargin)
                
                flex.addItem()
                    .direction(.column)
                    .alignItems(.start)
                    .marginRight(Constants.outerMargin)
                    .marginVertical(Constants.outerMargin)
                    .shrink(1)
                    .define { flex in
                        flex.addItem(nameLabel)
                        
                        flex.addItem(locationLabel)
                            .marginTop(Constants.innerTopMargin)
                        
                        flex.addItem(followersLabel)
                            .marginTop(Constants.innerTopMargin)
                    }
            }
    }
}

extension FollowingUserView: ConfigurableView {
    func configure(with model: FollowingUserViewModel) {
        avatarImageView.sd_setImage(with: model.avatarImageUrl)
        
        nameLabel.attributedText = model.nameString
        nameLabel.flex.markDirty()
        
        locationLabel.attributedText = model.locationString
        locationLabel.flex.display(model.locationString != nil ? .flex : .none)
        locationLabel.flex.markDirty()
        
        followersLabel.attributedText = model.followersString
        followersLabel.flex.display(model.followersString != nil ? .flex : .none)
        followersLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

private extension FollowingUserView {
    enum Constants {
        static let avatarSize: CGFloat = 60.0
        static let outerMargin: CGFloat = 8.0
        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4.0
        static let innerTopMargin: CGFloat = 4.0
    }
    
    enum Styles {
        static let backgroundColor = MMColors.white
        static let borderColor = MMColors.lightGray
    }
}

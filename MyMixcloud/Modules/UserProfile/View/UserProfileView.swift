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

final class UserProfileView: UIView {
    private let avatarImageView = UIImageView()
    private let coverImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationImageView = UIImageView()
    private let locationLabel = UILabel()
    private let bioLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    private let cloudcastsLabel = UILabel()
    
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
        
        coverImageView.contentMode = .scaleAspectFill
       
        nameLabel.backgroundColor = Styles.backgroundColor
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        locationImageView.image = UIImage(named: "locationIcon")
        locationImageView.contentMode = .scaleAspectFit
        locationLabel.backgroundColor = Styles.backgroundColor
        locationLabel.numberOfLines = 0
        
        bioLabel.backgroundColor = Styles.backgroundColor
        bioLabel.numberOfLines = 0
        
        followersLabel.backgroundColor = Styles.backgroundColor
        followingLabel.backgroundColor = Styles.backgroundColor
        cloudcastsLabel.backgroundColor = Styles.backgroundColor
    }
    
    private func createFlex() {
        flex.addItem(coverImageView)
            .position(.absolute)
            .top(0)
            .left(0)
            .width(100%)
            .height(Constants.coverImageSize)
                
        flex.addItem()
            .direction(.column)
            .marginHorizontal(Constants.contentHorizontalMargin)
            .marginVertical(Constants.contentVerticalMargin)
            .alignItems(.center)
            .define { flex in
                flex.addItem(avatarImageView)
                    .size(Constants.avatarImageSize)
                
                flex.addItem(nameLabel)
                    .marginTop(Constants.topMargin)

                flex.addItem()
                    .direction(.row)
                    .alignItems(.end)
                    .marginTop(Constants.topMargin)
                    .define { flex in
                        flex.addItem(locationImageView)
                            .size(Constants.locationImageSize)
                            .display(.none)
                        flex.addItem(locationLabel)
                            .marginLeft(Constants.locationLeftMargin)
                    }
                
                flex.addItem()
                    .direction(.row)
                    .marginTop(Constants.countersTopMargin)
                    .define { flex in
                        flex.addItem(followersLabel)
                            .marginRight(Constants.counterRightMargin)
                        flex.addItem(followingLabel)
                            .marginRight(Constants.counterRightMargin)
                        flex.addItem(cloudcastsLabel)
                }
                
                flex.addItem(bioLabel)
                    .marginTop(Constants.topMargin)
                    .alignSelf(.start)
            }
    }
}

extension UserProfileView: ConfigurableView {
    func configure(with model: UserProfileViewModel) {
        avatarImageView.sd_setImage(with: model.avatarImageUrl)
        
        coverImageView.sd_setImage(with: model.coverImageUrl)
        coverImageView.isHidden = (model.coverImageUrl == nil)
        
        nameLabel.attributedText = model.nameString
        nameLabel.flex.markDirty()
        
        let needShowLocation = model.locationString != nil
        locationImageView.flex.display(needShowLocation ? .flex : .none)
        locationLabel.attributedText = model.locationString
        locationLabel.flex.display(needShowLocation ? .flex : .none)
        locationLabel.flex.markDirty()
        
        bioLabel.attributedText = model.bioString
        bioLabel.flex.display(model.bioString != nil ? .flex : .none)
        bioLabel.flex.markDirty()
        
        followersLabel.attributedText = model.followersString
        followersLabel.flex.display(model.followersString != nil ? .flex : .none)
        followersLabel.flex.markDirty()
        
        followingLabel.attributedText = model.followingString
        followingLabel.flex.display(model.followingString != nil ? .flex : .none)
        followingLabel.flex.markDirty()
        
        cloudcastsLabel.attributedText = model.cloudcastsString
        cloudcastsLabel.flex.display(model.cloudcastsString != nil ? .flex : .none)
        cloudcastsLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

private extension UserProfileView {
     enum Constants {
        static let coverImageSize: CGFloat = 180.0
        static let contentHorizontalMargin: CGFloat = 20.0
        static let contentVerticalMargin: CGFloat = 30.0
        static let avatarImageSize: CGFloat = 200.0
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 20.0
        static let locationImageSize: CGFloat = 22.0
        static let locationLeftMargin: CGFloat = 10.0
        static let topMargin: CGFloat = 10.0
        static let countersTopMargin: CGFloat = 30.0
        static let counterRightMargin: CGFloat = 20.0
    }
    
    enum Styles {
        static let backgroundColor = MMColors.white
        static let borderColor = MMColors.lightGray
    }
}

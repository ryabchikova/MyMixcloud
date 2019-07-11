//
//  TrackView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import FlexLayout
import SDWebImage

final class TrackView: UIView {
    
    private let trackTitleLabel = UILabel()
    private let coverImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let audioLengthLabel = UILabel()
    private let uploadedLabel = UILabel()
    private let favoritedLabel = UILabel()
    private let listenedLabel = UILabel()
    private let repostedLabel = UILabel()
    private let tagsContainerView = UIView()
    
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
        trackTitleLabel.backgroundColor = Styles.backgroundColor
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = MMColors.imagePlaceholder
        coverImageView.layer.borderColor = MMColors.white.cgColor
        coverImageView.layer.borderWidth = Constants.coverBorderWidth
        coverImageView.layer.cornerRadius = Constants.coverCornerRadius
        coverImageView.layer.masksToBounds = true
        
        userNameLabel.backgroundColor = Styles.backgroundColor
        audioLengthLabel.backgroundColor = Styles.backgroundColor
        uploadedLabel.backgroundColor = Styles.backgroundColor
        favoritedLabel.backgroundColor = Styles.backgroundColor
        listenedLabel.backgroundColor = Styles.backgroundColor
        repostedLabel.backgroundColor = Styles.backgroundColor
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
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(trackTitleLabel)
                        
                        flex.addItem(userNameLabel)
                            .marginTop(Constants.tmpTopMargin)
                        
                        flex.addItem(coverImageView)
                            .size(Constants.coverImageSize)
                            .marginTop(Constants.tmpTopMargin)
                        
                        flex.addItem()
                            .direction(.row)
                            .marginTop(Constants.tmpTopMargin)
                            .define { flex in
                                flex.addItem(audioLengthLabel)
                                flex.addItem(uploadedLabel)
                            }
                        
                        flex.addItem()
                            .direction(.row)
                            .marginTop(Constants.tmpTopMargin)
                            .define { flex in
                                flex.addItem(listenedLabel)
                                flex.addItem(favoritedLabel)
                                flex.addItem(repostedLabel)
                            }
                        
                        flex.addItem(tagsContainerView)
                            .marginTop(Constants.tmpTopMargin)
                    }
            }
    }
    
    func update(with model: TrackViewModel) {
        trackTitleLabel.attributedText = model.trackTitleString
        trackTitleLabel.flex.markDirty()
        
        coverImageView.sd_setImage(with: model.coverImageUrl)

        userNameLabel.attributedText = model.userNameString
        userNameLabel.flex.markDirty()
        
        audioLengthLabel.attributedText = model.audioLengthString
        audioLengthLabel.flex.display(model.audioLengthString != nil ? .flex : .none)
        audioLengthLabel.flex.markDirty()
        
        uploadedLabel.attributedText = model.uploadedTimeString
        uploadedLabel.flex.display(model.uploadedTimeString != nil ? .flex : .none)
        uploadedLabel.flex.markDirty()
        
        favoritedLabel.attributedText = model.favoritedString
        favoritedLabel.flex.display(model.favoritedString != nil ? .flex : .none)
        favoritedLabel.flex.markDirty()
        
        listenedLabel.attributedText = model.listenedString
        listenedLabel.flex.display(model.listenedString != nil ? .flex : .none)
        listenedLabel.flex.markDirty()
        
        repostedLabel.attributedText = model.repostedString
        repostedLabel.flex.display(model.repostedString != nil ? .flex : .none)
        repostedLabel.flex.markDirty()
        
        // TODO
        tagsContainerView.flex.display(.none)
        tagsContainerView.flex.markDirty()
        
        setNeedsLayout()
    }
}

extension TrackView {
    
    private struct Constants {
        static let contentHorizontalMargin: CGFloat = 40.0
        static let coverImageSize: CGFloat = 200.0
        static let coverBorderWidth: CGFloat = 1.0
        static let coverCornerRadius: CGFloat = 20.0
        static let tmpTopMargin: CGFloat = 10.0         // TODO
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
    }
}

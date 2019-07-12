//
//  TrackListItemView.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import FlexLayout
import SDWebImage

final class TrackListItemView: UIView {
    private let trackId: String = ""
    private let coverImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let trackTitleLabel = UILabel()
    private let audioLengthLabel = UILabel()
    
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
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = MMColors.imagePlaceholder
        coverImageView.layer.borderColor = Styles.borderColor.cgColor
        coverImageView.layer.borderWidth = Constants.borderWidth
        coverImageView.layer.cornerRadius = Constants.cornerRadius
        coverImageView.layer.masksToBounds = true
        
        userNameLabel.backgroundColor = Styles.backgroundColor
        trackTitleLabel.backgroundColor = Styles.backgroundColor
        trackTitleLabel.numberOfLines = 2
        audioLengthLabel.backgroundColor = Styles.backgroundColor
    }
    
    private func createFlex() {
        flex.addItem()
            .direction(.row)
            .width(100%)
            .height(100%)
            .alignItems(.center)
            .define { flex in
                flex.addItem(coverImageView)
                    .size(Constants.coverSize)
                    .margin(Constants.outerMargin)
                
                flex.addItem()
                    .direction(.column)
                    .alignItems(.start)
                    .marginRight(Constants.outerMargin)
                    .marginVertical(Constants.outerMargin)
                    .shrink(1)
                    .define { flex in
                        flex.addItem(userNameLabel)

                        flex.addItem(trackTitleLabel)
                            .marginTop(Constants.innerTopMargin)

                        flex.addItem(audioLengthLabel)
                            .marginTop(Constants.innerTopMargin)
                    }
            }
    }
    
    func update(with model: TrackListItemViewModel) {
        coverImageView.sd_setImage(with: model.coverImageUrl)
        
        userNameLabel.attributedText = model.userNameString
        userNameLabel.flex.markDirty()
        
        trackTitleLabel.attributedText = model.trackTitleString
        trackTitleLabel.flex.markDirty()
        
        audioLengthLabel.attributedText = model.audioLengthString
        audioLengthLabel.flex.display(model.audioLengthString != nil ? .flex : .none)
        audioLengthLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

extension TrackListItemView {
    
    private struct Constants {
        static let coverSize: CGFloat = 60.0
        static let outerMargin: CGFloat = 8.0
        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4.0
        static let innerTopMargin: CGFloat = 4.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
        static let borderColor = MMColors.lightGray
    }
}

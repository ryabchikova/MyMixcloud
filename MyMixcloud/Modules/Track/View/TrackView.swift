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
    private let favoriteImageView = UIImageView()
    private let listenedLabel = UILabel()
    private let listenImageView = UIImageView()
    private let repostedLabel = UILabel()
    private let repostImageView = UIImageView()
    private let countersContainerView = UIView()
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
        trackTitleLabel.numberOfLines = 0
        trackTitleLabel.textAlignment = .center
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = MMColors.imagePlaceholder
        coverImageView.layer.borderColor = Styles.borderColor.cgColor
        coverImageView.layer.borderWidth = Constants.coverBorderWidth
        
        userNameLabel.backgroundColor = Styles.backgroundColor
        userNameLabel.numberOfLines = 0
        
        audioLengthLabel.backgroundColor = Styles.backgroundColor

        uploadedLabel.backgroundColor = Styles.backgroundColor
        
        favoriteImageView.image = UIImage(named: "favoriteIcon")
        favoriteImageView.tintColor = Styles.counterColor
        favoriteImageView.contentMode = .scaleAspectFit
        favoritedLabel.backgroundColor = Styles.backgroundColor
        
        listenImageView.image = UIImage(named: "listenIcon")
        listenImageView.tintColor = Styles.counterColor
        listenImageView.contentMode = .scaleAspectFit
        listenedLabel.backgroundColor = Styles.backgroundColor
        
        repostImageView.image = UIImage(named: "repostIcon")?.withRenderingMode(.alwaysTemplate)
        repostImageView.tintColor = Styles.counterColor
        repostImageView.contentMode = .scaleAspectFit
        repostedLabel.backgroundColor = Styles.backgroundColor
    }
    
    private func createFlex() {
        flex.addItem()
            .direction(.column)
            .marginHorizontal(Constants.contentHorizontalMargin)
            .marginVertical(Constants.contentVerticalMargin)
            .alignItems(.center)
            .define { flex in
                    flex.addItem(trackTitleLabel)
                
                    flex.addItem(userNameLabel)
                        .marginTop(Constants.rowTopMargin)
                
                    flex.addItem(coverImageView)
                        .width(100%)
                        .aspectRatio(1.0)
                        .marginTop(Constants.secionTopMargin)
                
                    flex.addItem()
                        .direction(.row)
                        .width(100%)
                        .marginTop(Constants.rowTopMargin)
                        .justifyContent(.spaceBetween)
                        .wrap(.wrap)
                        .define { flex in
                            flex.addItem(audioLengthLabel)
                                .marginRight(Constants.innerHorizontalMargin)
                            flex.addItem(uploadedLabel)
                                .shrink(1)
                        }
                
                    flex.addItem(countersContainerView)
                        .direction(.row)
                        .marginTop(Constants.secionTopMargin)
                        .alignSelf(.start)
                        .define { flex in
                            let counterViewContent = [(favoriteImageView, favoritedLabel),
                                                      (listenImageView, listenedLabel),
                                                      (repostImageView, repostedLabel)]
                            
                            counterViewContent.forEach { arg in
                                let (imageView, label) = arg
                                flex.addItem(makeCounterView())
                                    .direction(.row)
                                    .marginRight(Constants.innerHorizontalMargin)
                                    .justifyContent(.spaceAround)
                                    .padding(Constants.counterViewMargin)
                                    .alignItems(.center)
                                    .define { flex in
                                        flex.addItem(imageView)
                                            .size(Constants.counterViewImageSize)
                                            .marginRight(Constants.counterViewMargin)
                                        flex.addItem(label)
                                }
                            }
                        }
                
                    flex.addItem(tagsContainerView)
                        .direction(.row)
                        .marginTop(Constants.rowTopMargin)
                        .alignSelf(.start)
                        .wrap(.wrap)
            }
    }
    
    private func makeCounterView() -> UIView {
        let view = UIView()
        view.backgroundColor = Styles.backgroundColor
        view.layer.borderColor = Styles.counterColor.cgColor
        view.layer.borderWidth = Constants.counterBorderWidth
        view.layer.cornerRadius = Constants.counterCornerRadius
        view.layer.masksToBounds = true
        return view
    }
    
    private func makeTagLabel(with text: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.backgroundColor = Styles.backgroundColor
        label.attributedText = text
        return label
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
        favoritedLabel.flex.markDirty()
        
        listenedLabel.attributedText = model.listenedString
        listenedLabel.flex.markDirty()
        
        repostedLabel.attributedText = model.repostedString
        repostedLabel.flex.markDirty()

        let shouldShowCounters = model.favoritedString != nil || model.listenedString != nil || model.repostedString != nil
        countersContainerView.flex.display(shouldShowCounters ? .flex : .none)
        countersContainerView.flex.markDirty()
        
        tagsContainerView.subviews.forEach { $0.removeFromSuperview() }
        model.tags.map { $0.forEach { tagsContainerView.flex.addItem(makeTagLabel(with: $0)).marginRight(Constants.innerHorizontalMargin) }}
        tagsContainerView.flex.display(tagsContainerView.subviews.isEmpty ? .none : .flex)
        tagsContainerView.flex.markDirty()
        
        setNeedsLayout()
    }
}

extension TrackView {
    
    private struct Constants {
        static let contentHorizontalMargin: CGFloat = 40.0
        static let contentVerticalMargin: CGFloat = 30.0
        static let coverBorderWidth: CGFloat = 1.0
        static let rowTopMargin: CGFloat = 10.0
        static let secionTopMargin: CGFloat = 30.0
        static let innerHorizontalMargin: CGFloat = 10.0
        static let counterBorderWidth: CGFloat = 1.0
        static let counterCornerRadius: CGFloat = 4.0
        static let counterViewMargin: CGFloat = 5.0
        static let counterViewImageSize: CGFloat = 15.0
    }
    
    private struct Styles {
        static let backgroundColor = MMColors.white
        static let borderColor = MMColors.lightGray
        static let counterColor = MMColors.blue
    }
}

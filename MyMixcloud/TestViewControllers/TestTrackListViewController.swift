//
//  TestTrackListViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

enum ViewTheme {
    case cold, hot
}

final class TestTrackListViewController: UIViewController {
    private let theme: ViewTheme
    
    init(theme: ViewTheme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.isOpaque = false
        switch  theme {
        case .cold:
            view.backgroundColor = .blue
        case .hot:
            view.backgroundColor = .orange
        }
        
        self.view = view
    }
}

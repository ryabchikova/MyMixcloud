//
//  TestTrackListViewController.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class TestViewController: UIViewController {
    private let text: String
    private let background: UIColor
    
    init(text: String, background: UIColor) {
        self.text = text
        self.background = background
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = background
        self.view = view
        
        let label = UILabel(frame: self.view.frame)
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40.0)
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        label.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

//
//  UIViewController+ActivityIndicator.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicatorSupport {

    var activityIndicator: UIActivityIndicatorView { get }
    func showActivity()
    func hideActivity()
}


extension UIViewController: ActivityIndicatorSupport {
    
    var activityIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.color = MMColors.darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    func showActivity() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.center = self.view.center
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivity() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}

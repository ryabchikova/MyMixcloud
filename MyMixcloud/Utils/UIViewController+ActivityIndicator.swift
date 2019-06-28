//
//  UIViewController+ActivityIndicator.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

// ТУТ УТЕКАЕТ ПАМЯТЬ, ЭТО НЕ ПРАВИЛЬНЫЙ ПОДХОД
// ПЕРЕДЕЛАТЬ


//protocol ActivityIndicatorSupport {
//    func showActivity()
//    func hideActivity()
//}
//
//extension UIViewController: ActivityIndicatorSupport {
//
//    private var activityIndicator: UIActivityIndicatorView {
//        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        indicator.color = MMColors.darkGray
//        indicator.hidesWhenStopped = true
//        return indicator
//    }
//
//    func showActivity() {
//        DispatchQueue.main.async {
//            print("1:", self.view.subviews.count)
//            self.view.addSubview(self.activityIndicator)
//            print("3:", self.view.subviews.count)
//            self.activityIndicator.center = self.view.center
//            self.activityIndicator.startAnimating()
//        }
//    }
//
//    func hideActivity() {
//        DispatchQueue.main.async {
//            print("3:", self.view.subviews.count)
//            self.activityIndicator.stopAnimating()
//            self.activityIndicator.removeFromSuperview()
//            print("4:", self.view.subviews.count)
//        }
//    }
//}

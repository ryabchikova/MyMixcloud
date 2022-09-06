//
//  Module.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 10.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

struct Module<Input> {
    
    let viewController: UIViewController
    let moduleInput: Input
    
    init(_ viewController: UIViewController, _ moduleInput: Input) {
        self.viewController = viewController
        self.moduleInput = moduleInput
    }
    
}


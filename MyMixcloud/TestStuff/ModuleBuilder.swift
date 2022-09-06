//
//  ModuleBuilder.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 10.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import UIKit

// As Protocol implementation
protocol ModuleContext {}

// When module hasn't context
struct EmptyContext: ModuleContext {}

protocol ModuleBuilder {
    associatedtype Context: ModuleContext
    associatedtype ModuleInput
    
    static func build(with context: Context) -> Module<ModuleInput>
}

// Sample
protocol XModuleInput: AnyObject {}
final class XPresenter: XModuleInput {}

struct XModuleBuilder: ModuleBuilder {

    private init() {}

    static func build(with context: EmptyContext) -> Module<XModuleInput> {
        return Module(UIViewController(), XPresenter())
    }

}

//
//  BusinessModelConvertible.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 31.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

protocol BusinessModelConvertible {
    associatedtype T
    var businessModel: T { get }
}

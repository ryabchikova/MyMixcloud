//
//  DummyViewPresentable.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 09.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//


protocol DummyViewDisplayable: AnyObject {
    func showDummyView(for error: MMError, retryHandler: @escaping () -> Void)
    func hideDummyViewIfNeed()
}

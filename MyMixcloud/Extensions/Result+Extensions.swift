//
//  Result+Extensions.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 26.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

extension Result {

//    @discardableResult
//    func onSuccess(_ handler: (Success) -> Void) -> Self {
//        if case let .success(value) = self {
//            handler(value)
//        }
//        return self
//    }
//
//    @discardableResult
//    func onFailure(_ handler: (Failure) -> Void) -> Self {
//        if case let .failure(error) = self {
//            handler(error)
//        }
//        return self
//    }
    
    func onSuccess(_ handler: (Success) -> Void) {
        guard case let .success(value) = self else { return }
        handler(value)
    }

    func onFailure(_ handler: (Failure) -> Void) {
        guard case let .failure(error) = self else { return }
        handler(error)
    }

}

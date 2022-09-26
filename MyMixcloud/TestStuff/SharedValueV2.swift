//
//  SharedValueV2.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

// Simple class implementation
final class SharedValueV2<T>: NSLock {
    private var value: T

    init(_ value: T) {
        self.value = value
    }

    func `get`() -> T {
        lock()
        let oldValue = value
        unlock()
        return oldValue
    }

    func `set`(_ value: T) {
        lock(); defer { unlock() }
        self.value = value
    }
}

//
//  SharedValue.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 06.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

/**
 Thread-safe value wrapper for shared data
 */
@propertyWrapper
final class SharedValue<T>: NSLock {
    private var value: T
    var wrappedValue: T {
        get {
            lock()
            let oldValue = value
            unlock()
            return oldValue
        }
        set {
            lock(); defer { unlock() }
            value = newValue
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}


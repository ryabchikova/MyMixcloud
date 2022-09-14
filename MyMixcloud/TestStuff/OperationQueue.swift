//
//  OperationQueue.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 13.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

final class BaseOperation: Operation {
    private let task: () -> Void
    
    init(task: @escaping () -> Void) {
        self.task = task
    }
    
    override func main() {
        task()
    }
}

func testOperations() {

    print("[Start]", Thread.current.description)
    var journal = ""
    var res1 = 0
    var res2 = 0
    var res3 = 0
    
    let op1 = BaseOperation {
        sleep(1)
        print(Thread.current.description, "execute operation1")
        res1 = 2
        journal.append("op1 finished.")
    }
    
    
    let op2 = BaseOperation {
        print(Thread.current.description, "execute operation2")
        res2 = res1 * 2
        journal.append("op2 finished.")
    }
    
    
    let op3 = BaseOperation {
        print(Thread.current.description, "execute operation3")
        res3 = res2 * 3
        journal.append("op3 finished.")
    }
    op2.addDependency(op1)
    op3.addDependency(op2)

    let operationQueue = OperationQueue()
    operationQueue.addOperations([op1, op2, op3], waitUntilFinished: true)
}

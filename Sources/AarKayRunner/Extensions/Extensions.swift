//
//  Extensions.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 17/03/18.
//

import Foundation
import ReactiveTask
import ReactiveSwift
import Result

private let outputQueue = { () -> DispatchQueue in
    let targetQueue = DispatchQueue.global(qos: .userInitiated)
    let queue = DispatchQueue(
        label: "me.RahulKatariya.AarKay.outputQueue",
        target: targetQueue
    )
#if !os(Linux)
    atexit_b { queue.sync(flags: .barrier) {} }
#endif
    return queue
}()

/// A thread-safe version of Swift's standard println().
internal func asyncPrintln() {
    outputQueue.async { Swift.print() }
}

/// A thread-safe version of Swift's standard println().
internal func asyncPrintln<T>(_ object: T) {
    outputQueue.async { Swift.print(object) }
}

/// A thread-safe version of Swift's standard print().
internal func asyncPrint<T>(_ object: T) {
    outputQueue.async { Swift.print(object, terminator: "") }
}

extension SignalProducer where Value == TaskEvent<String?>, Error == TaskError {
    /// Waits on a SignalProducer that implements the behavior of a CommandProtocol.
    internal func waitOnCommand() -> Result<(), TaskError> {
        let result = producer
            .on(event: { event in
                switch event {
                case .value(let value):
                    switch value {
                    case .standardOutput(let data):
                        if let o = String(data: data, encoding: .utf8) {
                           asyncPrint(o)
                        }
                    default: break
                    }
                default: break
                }
            })
            .then(SignalProducer<(), TaskError>.empty)
            .wait()
        
        Task.waitForAllTaskTermination()
        return result
    }
    
}

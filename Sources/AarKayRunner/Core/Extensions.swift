// Inspired by the Carthage library:
// https://github.com/Carthage/Carthage
/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Carthage contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation
import ReactiveTask
import ReactiveSwift
import Result
import AarKayRunnerKit

/// A queue to print all logs on console asynchrously.
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
internal func println() {
    outputQueue.async {
        Swift.print()
    }
}

/// A thread-safe version of Swift's standard println().
internal func println<T>(_ object: T) {
    outputQueue.async {
        Swift.print(object)
    }
}

/// A thread-safe version of Swift's standard print().
internal func print<T>(_ object: T) {
    outputQueue.async {
        Swift.print(object, terminator: "")
    }
}

extension String {
    /// Split the string into substrings separated by the given separators.
    internal func split(maxSplits: Int = .max, omittingEmptySubsequences: Bool = true, separators: [Character] = [ ",", " " ]) -> [String] {
        return split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: separators.contains)
            .map(String.init)
    }
}

extension Task {
    
    /// Launches the task and converts the task data to string.
    ///
    /// - Returns: A result containing either success or `AarKayError`
    internal func run() -> Result<(), AarKayError> {
        let result = launch()
            .flatMapTaskEvents(.concat) { data in
                return SignalProducer(
                    value: String(data: data, encoding: .utf8)
                )
        }
        return result.waitOnCommand()
    }
    
}

extension SignalProducer where Value == TaskEvent<String?>, Error == TaskError {
    /// Waits on a SignalProducer that implements the behavior of a CommandProtocol.
    internal func waitOnCommand() -> Result<(), AarKayError> {
        let result = producer
            .on(event: { event in
                switch event {
                case .value(let value):
                    switch value {
                    case .standardOutput(let data):
                        if let o = String(data: data, encoding: .utf8) {
                            print(o)
                        }
                    default: break
                    }
                default: break
                }
            })
            .mapError(AarKayError.taskError)
            .then(SignalProducer<(), AarKayError>.empty)
            .wait()
        
        Task.waitForAllTaskTermination()
        return result
    }
}

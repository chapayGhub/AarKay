//
//  BuildTask.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 01/01/19.
//

import Foundation
import ReactiveSwift
import ReactiveTask
import Result

/// A type that encapsulates all task events in AarKay.
class Tasks {
    
    /// Builds the `AarKayRunner` swift package.
    ///
    /// - Parameter path: The working directory path.
    /// - Returns: A result containing either success or `AarKayError`
    static func build(at path: String) -> Result<(), AarKayError> {
        let buildArguments = [
            "build", "-c", "release",
            "-Xswiftc", "-target", "-Xswiftc", "x86_64-apple-macosx10.12"
        ]
        let task = Task(
            "/usr/bin/swift",
            arguments: buildArguments,
            workingDirectoryPath: path
        )
        return task.run()
    }
    
    /// Updates the dependencies of `AarKayRunner` swift package
    ///
    /// - Parameter path: The working directory path.
    /// - Returns: A result containing either success or `AarKayError`
    static func update(at path: String) -> Result<(), AarKayError> {
        let buildArguments = [
            "package",
            "update"
        ]
        let task = Task(
            "/usr/bin/swift",
            arguments: buildArguments,
            workingDirectoryPath: path
        )
        let result = task.run()
        guard result.error == nil else { return result }
        return build(at: path)
    }
    
    /// Resolves the `AarKayRunner` swift packages with respect to Package.resolved.
    ///
    /// - Parameter path: The working directory path.
    /// - Returns: A result containing either success or `AarKayError`
    static func install(at path: String) -> Result<(), AarKayError> {
        let buildArguments = [
            "package",
            "resolve"
        ]
        let task = Task(
            "/usr/bin/swift",
            arguments: buildArguments,
            workingDirectoryPath: path
        )
        let result = task.run()
        guard result.error == nil else { return result }
        return build(at: path)
    }
    
    /// Executes the path as the shell command.
    ///
    /// - Parameter
    ///   - path: The path to execute as shell command.
    ///   - arguments: The list of arguments
    /// - Returns: A result containing either success or `AarKayError`
    static func execute(at path: String, arguments: [String] = []) -> Result<(), AarKayError> {
        return Task(path, arguments: arguments).run()
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

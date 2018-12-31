//
//  BashProcess.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation

/// A type that encapsulates bash commands.
class BashProcess {

    /// Creates a process to run a command.
    ///
    /// - Parameters:
    ///   - command: The command to run.
    ///   - url: The directory url in which command will run.
    /// - Returns: The termination status of the process
    static func run(command: String, url: URL) -> Int32 {
        let process = Process()
        process.launchPath = "/bin/bash"
        process.arguments = ["-c", command]
        process.currentDirectoryPath = url.path
        process.launch()
        process.waitUntilExit()
        return process.terminationStatus
    }
    
}

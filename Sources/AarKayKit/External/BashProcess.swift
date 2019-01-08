//
//  BashProcess.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 05/05/18.
//

import Foundation

class BashProcess {
    static func run(command: String, cwd: URL) -> Int32 {
        let process = Process()
        process.launchPath = "/bin/bash"
        process.arguments = ["-c", command]
        process.currentDirectoryPath = cwd.path
        process.launch()
        process.waitUntilExit()
        return process.terminationStatus
    }
}

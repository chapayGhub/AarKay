//
//  Init.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation
import Commandant
import ReactiveTask
import ReactiveSwift
import Result

struct InitCommand: CommandProtocol {
    
    var verb: String = "init"
    var function: String = "Initializes and installs all plugins from ~/AarKay/AarKayFile"
    
    func run(_ options: NoOptions<TaskError>) -> Result<(), TaskError> {
        print("Setting up ~/AarKay/AarKayRunner. This might take a few minutes...")
        try? FileManager.default.removeItem(at: FileManager.default.aarkayRunnerDirectory)
        Runner.bootstrap()
        let buildArguments = [
            "build",
            "-Xswiftc", "-target", "-Xswiftc", "x86_64-apple-macosx10.12"
        ]
        let taskResult = Task(
            "/usr/bin/swift",
            arguments: buildArguments,
            workingDirectoryPath: FileManager.default.aarkayRunnerDirectory.path
        )
            .launch()
            .flatMapTaskEvents(.concat) {
                SignalProducer(value: String(data: $0, encoding: .utf8))
        }
        
        return taskResult.waitOnCommand()
    }
    
}

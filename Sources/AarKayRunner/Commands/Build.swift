//
//  Build.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 20/12/18.
//

import Foundation
import Commandant
import ReactiveTask
import ReactiveSwift
import Result

struct BuildCommand: CommandProtocol {
    
    var verb: String = "build"
    var function: String = "Builds aarkay with plugins"
    
    func run(_ options: NoOptions<TaskError>) -> Result<(), TaskError> {
        print("Building AarKay with Plugins. This might take a few minutes...")
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

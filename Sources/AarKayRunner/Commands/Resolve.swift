//
//  Resolve.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation
import Commandant
import ReactiveTask
import ReactiveSwift
import Result

struct ResolveCommand: CommandProtocol {
    
    var verb: String = "resolve"
    var function: String = "Resolves all plugins"
    
    func run(_ options: NoOptions<TaskError>) -> Result<(), TaskError> {
        print("Resolving Plugins. This might take a few minutes...")
        let buildArguments = ["package", "resolve"]
        let taskResult = Task(
            "/usr/bin/swift",
            arguments: buildArguments,
            workingDirectoryPath: FileManager.default.aarkayRunnerDirectory.path
        )
            .launch()
            .flatMapTaskEvents(.concat) {
                SignalProducer(value: String(data: $0, encoding: .utf8))
            }
            .waitOnCommand()
        
        switch taskResult {
        case .success(_):
            return BuildCommand().run(options)
        case .failure(_):
            return taskResult
        }
    }
    
}

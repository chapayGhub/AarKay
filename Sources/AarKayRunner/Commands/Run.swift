//
//  Run.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation
import Commandant
import ReactiveTask
import ReactiveSwift
import Result

struct RunCommand: CommandProtocol {
    
    var verb: String = "run"
    var function: String = "Create files with respect to Project and Templates"
    
    func run(_ options: NoOptions<TaskError>) -> Result<(), TaskError> {
        Runner.bootstrap()
        
        guard FileManager.default.fileExists(
            atPath: FileManager.default.aarkayBuildDirectory.path
        ) else {
            print("Use 'aarkay init' to setup")
            return .success(())
        }
        
        guard FileManager.default.fileExists(atPath: FileManager.default.aarkayCLI.path) else {
            print("Unknown Error: use 'aarkay init' to start over")
            return .success(())
        }
        
        let taskResult = Task(FileManager.default.aarkayCLI.path)
            .launch()
            .flatMapTaskEvents(.concat) { data in
                return SignalProducer(
                    value: String(data: data, encoding: .utf8)
                )
        }
        
        return taskResult.waitOnCommand()

    }
    
}

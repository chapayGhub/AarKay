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
        try? FileManager.default.removeItem(at: FileManager.default.aarkayBuildDirectory)
        Runner.bootstrap()
        return BuildCommand().run(options)
    }
    
}

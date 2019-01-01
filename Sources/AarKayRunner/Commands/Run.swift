//
//  Run.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation
import Commandant
import Result
import Curry

/// Type that encapsulates the configuration and evaluation of the `run` subcommand.
struct RunCommand: CommandProtocol {
    struct Options: OptionsProtocol {
        let global: Bool
        let verbose: Bool
        let force: Bool
        
        public static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<AarKayError>> {
            return curry(self.init)
                <*> mode <| Switch(flag: "g", key: "global", usage: "Uses global version of `aarkay`.")
                <*> mode <| Switch(flag: "v", key: "verbose", usage: "Adds verbose logging.")
                <*> mode <| Switch(flag: "f", key: "force", usage: "Will not check if the directory has any uncomitted changes.")
        }
    }

    var verb: String = "run"
    var function: String = "Generate respective files from the datafiles inside AarKayData"
    
    func run(_ options: Options) -> Result<(), AarKayError> {
        var runnerUrl = FileManager.runnerPath()
        if !FileManager.default.fileExists(atPath: runnerUrl.path) || options.global {
            let globalRunnerUrl = FileManager.runnerPath(global: options.global)
            runnerUrl = globalRunnerUrl
        }
        
        guard FileManager.default.fileExists(atPath: runnerUrl.path) else {
            return .failure(.missingProject(runnerUrl.deletingLastPathComponent().path))
        }
        
        let cliUrl = runnerUrl.appendingPathComponent(".build/release/aarkay-cli")
        var arguments: [String] = []
        if options.verbose { arguments.append("--verbose") }
        if options.force { arguments.append("--force") }
        return Tasks.execute(at: cliUrl.path, arguments: arguments)
    }
}

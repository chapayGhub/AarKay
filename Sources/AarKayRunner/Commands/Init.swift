//
//  Init.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation
import Commandant
import Result
import Curry

/// Type that encapsulates the configuration and evaluation of the `init` subcommand.
struct InitCommand: CommandProtocol {
    struct Options: OptionsProtocol {
        let global: Bool
        let force: Bool
        
        public static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<AarKayError>> {
            return curry(self.init)
                <*> mode <| Switch(flag: "g", key: "global", usage: "Uses global version of `aarkay`.")
                <*> mode <| Switch(flag: "f", key: "force", usage: "Resets aarkay and starts over.")
        }
    }

    var verb: String = "init"
    var function: String = "Initialize AarKay and install all the plugins from `AarKayFile`."
    
    func run(_ options: Options) -> Result<(), AarKayError> {
        let url = FileManager.directoryPath(global: options.global)
        let runnerUrl = FileManager.runnerPath(global: options.global)
        if FileManager.default.fileExists(atPath: runnerUrl.path) && !options.force {
            return .failure(.projectAlreadyExists(url.path))
        } else {
            do {
                try Runner.bootstrap(global: options.global, force: options.force)
            } catch {
                return .failure(.bootstap(error))
            }
            let runnerUrl = FileManager.runnerPath(global: options.global)
            println("Setting up \(url.path). This might take a few minutes...")
            return Tasks.install(at: runnerUrl.path)
        }
    }
}

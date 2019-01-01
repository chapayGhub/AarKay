//
//  Update.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation
import Commandant
import Result
import Curry

/// Type that encapsulates the configuration and evaluation of the `update` subcommand.
struct UpdateCommand: CommandProtocol {
    struct Options: OptionsProtocol {
        let global: Bool
        
        public static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<AarKayError>> {
            return curry(self.init)
                <*> mode <| Switch(flag: "g", key: "global", usage: "Uses global version of `aarkay`.")
        }
    }

    var verb: String = "update"
    var function: String = "Update all the plugins from `AarKayFile`."
    
    func run(_ options: Options) -> Result<(), AarKayError> {
        let url = FileManager.runnerPath(global: options.global)
        guard FileManager.default.fileExists(atPath: url.path) else {
            return .failure(.missingProject(url.path))
        }
        println("Updating Plugins at \(url.path). This might take a few minutes...")
        return Tasks.update(at: url.path)
    }
}

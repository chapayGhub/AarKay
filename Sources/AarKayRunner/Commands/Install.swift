//
//  Install.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import AarKayRunnerKit
import Commandant
import Curry
import Foundation
import Result

/// Type that encapsulates the configuration and evaluation of the `install` subcommand.
struct InstallCommand: CommandProtocol {
    struct Options: OptionsProtocol {
        let global: Bool

        public static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<AarKayError>> {
            return curry(self.init)
                <*> mode <| Switch(flag: "g", key: "global", usage: "Uses global version of `aarkay`.")
        }
    }

    var verb: String = "install"
    var function: String = "Install all the plugins from `AarKayFile`."

    func run(_ options: Options) -> Result<(), AarKayError> {
        let runnerUrl = AarKayPaths.runnerPath(global: options.global)

        guard FileManager.default.fileExists(atPath: runnerUrl.path) else {
            return .failure(.missingProject(runnerUrl.deletingLastPathComponent().path))
        }

        do {
            try Bootstrapper.updatePackageSwift(global: options.global)
        } catch {
            return .failure(.bootstap(error))
        }
        println("Installing plugins at \(runnerUrl.path). This might take a few minutes...")
        return Tasks.install(at: runnerUrl.path)
    }
}

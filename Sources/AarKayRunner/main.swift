import Foundation
import Commandant
import ReactiveTask

let version = "v0.0.13"

/// Command registry containing all commands supported by `AarKay`.
let registry = CommandRegistry<AarKayError>()
registry.register(InitCommand())
registry.register(InstallCommand())
registry.register(RunCommand())
registry.register(UpdateCommand())
registry.register(HelpCommand(registry: registry))

/// Setting the default command to `run` instead of `help`.
registry.main(defaultVerb: "run") { error in
    fputs(error.description + "\n", stderr)
}

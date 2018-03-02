import Foundation
import Commandant
import ReactiveTask

let registry = CommandRegistry<TaskError>()
registry.register(InitCommand())
registry.register(RunCommand())
registry.register(UpdateCommand())
registry.register(ResolveCommand())

let helpCommand = HelpCommand(registry: registry)
registry.register(helpCommand)

registry.main(defaultVerb: "run") { error in
    fputs(error.description + "\n", stderr)
}

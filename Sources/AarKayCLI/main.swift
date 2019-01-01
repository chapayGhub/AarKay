import Foundation
import AarKay

/// The root url of the project from current file location which is ./Sources/AarKayCLI/main.swift.
let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

/// Bootstap aarkay in the url and options provided.
let options = AarKayOptions(
    force: CommandLine.arguments.contains("--force"),
    verbose: CommandLine.arguments.contains("--verbose")
)
AarKay(url: url, options: options).bootstrap()

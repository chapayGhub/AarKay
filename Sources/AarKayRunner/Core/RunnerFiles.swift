//
//  StringExtensions.swift
//  AarKay
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation

class RunnerFiles {

    /// The `main.swift` string for `AarKayRunner`
    static let cliSwift = """
    import Foundation
    import AarKay

    let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    let options = AarKayOptions(
        force: CommandLine.arguments.contains("--force"),
        verbose: CommandLine.arguments.contains("--verbose")
    )
    AarKay(url: url, options: options).bootstrap()
    """

    /// The package description string for `AarKayRunner`
    static let packageSwift = """
    // swift-tools-version:4.2
    import PackageDescription
    import Foundation

    var urls: [String] = [
        "https://github.com/RahulKatariya/AarKay.git",
        "https://github.com/RahulKatariya/AarKayKit.git"
    ]

    let aarkayFileUrl = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("AarKayFile", isDirectory: false)

    if let lines = try? String(contentsOf: aarkayFileUrl).components(separatedBy: .newlines) {
        let depUrls = lines.filter { !$0.isEmpty }
        urls = urls + depUrls
    }

    let dependencies = urls.map { Package.Dependency.package(url: $0, .upToNextMinor(from: "0.0.0")) }
    let targets = urls.map { URL(string: $0)!.deletingPathExtension().lastPathComponent }
    let targetDependencies = targets.map { Target.Dependency._byNameItem(name: $0) }
        + [Target.Dependency._byNameItem(name: "AarKayPlugin")]

    let package = Package(
        name: "AarKayRunner",
        products: [
            .executable(name: "aarkay-cli", targets: ["aarkay-cli"])
        ],
        dependencies: dependencies,
        targets: [
            .target(name: "aarkay-cli", dependencies: targetDependencies, path: "Sources/AarKayCLI"),
        ],
        swiftLanguageVersions: [.v4, .v4_2]
    )
    """

    /// The .swift-version string
    static let swiftVersion = "4.2.1"
    
    /// An empty aarkay string that will contain user installed plugins.
    static let aarkayFile = """
    """

}

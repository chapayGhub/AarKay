//
//  StringExtensions.swift
//  AarKay
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation

class RunnerFiles {

    static let cliSwift = """
    import Foundation
    import AarKay

    let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    AarKay(url: url).bootstrap()
    """

    static let packageSwift = """
    // swift-tools-version:4.0
    import PackageDescription
    import Foundation
    
    var urls = [
        "https://github.com/RahulKatariya/AarKay.git",
        "https://github.com/RahulKatariya/AarKayKit.git"
    ]
    
    let aarkayFileUrl = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("AarKay/AarKayFile", isDirectory: false)

    if let lines = try? String(contentsOf: aarkayFileUrl).components(separatedBy: .newlines) {
        let depUrls = lines.filter { !$0.isEmpty }
        urls = urls + depUrls
    }

    let dependencies = urls.map { Package.Dependency.package(url: $0, .upToNextMinor(from: "0.0.0")) }
    let targets = urls.map { URL(string: $0)!.deletingPathExtension().lastPathComponent }
    let targetDependencies = targets.map { Target.Dependency.byNameItem(name: $0) }
        + [Target.Dependency.byNameItem(name: "AarKayPlugin")]
    
    let package = Package(
        name: "AarKayRunner",
        products: [
            .executable(name: "aarkay-cli", targets: ["aarkay-cli"])
        ],
        dependencies: dependencies,
        targets: [
            .target(name: "aarkay-cli", dependencies: targetDependencies, path: "Sources/AarKayCLI"),
        ],
        swiftLanguageVersions: [4]
    )
    """

    static let swiftVersion = "4.2"

}

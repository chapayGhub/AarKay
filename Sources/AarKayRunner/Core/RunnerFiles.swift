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

    /// The .swift-version string
    static let swiftVersion = "4.2.1"
    
    /// An empty aarkay string that will contain user installed plugins.
    static let aarkayFile = ""

    /// The package description string for `AarKayRunner`
    static func packageSwift(urls: [URL]) -> String {
        let packages = urls.reduce("") { (result, url) -> String in
            return result + """
            \n        .package(url: "\(url.path)", .upToNextMinor(from: "0.0.0")),
            """
        }
        
        let dependencies = urls.reduce("") { (result, url) -> String in
            return result + " \"" + url.deletingPathExtension().lastPathComponent + "\","
        }
        
        return """
        // swift-tools-version:4.2
        import PackageDescription
        import Foundation
        
        let package = Package(
            name: "AarKayRunner",
            products: [
                .executable(name: "aarkay-cli", targets: ["aarkay-cli"])],
            dependencies: [
                .package(url: "https://github.com/RahulKatariya/AarKay.git", .upToNextMinor(from: "0.0.0")),
                .package(url: "https://github.com/RahulKatariya/AarKayKit.git", .upToNextMinor(from: "0.0.0")),\(packages)],
            targets: [
                .target(
                    name: "aarkay-cli",
                    dependencies: ["AarKay", "AarKayKit", "AarKayPlugin",\(dependencies)],
                    path: "Sources/AarKayCLI"),],
            swiftLanguageVersions: [.v4, .v4_2]
        )
        """
    }
    
}

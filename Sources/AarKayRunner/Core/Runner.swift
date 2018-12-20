//
//  Runner.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation

class Runner {

    static func bootstrap() {
        createCLISwift()
        createPackageSwift()
        createSwiftVersion()
    }

    private static func createCLISwift() {
        let mainSwiftUrl = FileManager.default.aarkayRunnerDirectory
            .appendingPathComponent("Sources")
            .appendingPathComponent("AarKayCLI")
            .appendingPathComponent("main.swift", isDirectory: false)
        try? FileManager.default.removeItem(at: mainSwiftUrl)
        try! FileManager.default.createDirectory(
            at: mainSwiftUrl.deletingLastPathComponent(),
            withIntermediateDirectories: true,
            attributes: nil
        )
        try! RunnerFiles.cliSwift.write(to: mainSwiftUrl, atomically: true, encoding: .utf8)
    }

    private static func createPackageSwift() {
        let packageSwiftUrl = FileManager.default.aarkayRunnerDirectory
            .appendingPathComponent("Package.swift", isDirectory: false)
        try? FileManager.default.removeItem(at: packageSwiftUrl)
        try! FileManager.default.createDirectory(
            at: packageSwiftUrl.deletingLastPathComponent(),
            withIntermediateDirectories: true,
            attributes: nil
        )
        try! RunnerFiles.packageSwift.write(to: packageSwiftUrl, atomically: true, encoding: .utf8)
    }

    private static func createSwiftVersion() {
        let swiftVersionUrl = FileManager.default.aarkayRunnerDirectory
            .appendingPathComponent(".swift-version", isDirectory: false)
        try? FileManager.default.removeItem(at: swiftVersionUrl)
        try! FileManager.default.createDirectory(
            at: swiftVersionUrl.deletingLastPathComponent(),
            withIntermediateDirectories: true,
            attributes: nil
        )
        try! RunnerFiles.swiftVersion.write(to: swiftVersionUrl, atomically: true, encoding: .utf8)
    }

}

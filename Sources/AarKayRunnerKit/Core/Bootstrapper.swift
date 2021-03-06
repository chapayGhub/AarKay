//
//  Bootstrapper.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation

/// Type that encapsulates creation of all files required by `AarKayRunner`.
public class Bootstrapper {
    /// Creates all files required to run `AarKay`.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    public static func bootstrap(global: Bool = false, force: Bool = false) throws {
        if force {
            let buildUrl = AarKayPaths.buildPath(global: global)
            if FileManager.default.fileExists(atPath: buildUrl.path) {
                try FileManager.default.removeItem(at: buildUrl)
            }
            let packageResolvedUrl = AarKayPaths.packageResolved(global: global)
            if FileManager.default.fileExists(atPath: packageResolvedUrl.path) {
                try FileManager.default.removeItem(at: packageResolvedUrl)
            }
        }
        try self.createCLISwift(global: global, force: force)
        try self.createAarKayFile(global: global)
        try self.updatePackageSwift(global: global)
        try self.createSwiftVersion(global: global, force: force)
    }

    /// Creates CLI main.swift file
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createCLISwift(global: Bool, force: Bool = false) throws {
        let url = AarKayPaths.mainSwift(global: global)
        try write(string: RunnerFiles.cliSwift, url: url, force: force)
    }

    /// Creates .swift-version file.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createSwiftVersion(global: Bool, force: Bool = false) throws {
        let url = AarKayPaths.swiftVersion(global: global)
        try write(string: RunnerFiles.swiftVersion, url: url, force: force)
    }

    /// Creates `AarKayFile` if it doesn't exist already.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    /// - Throws: File manager errors
    private static func createAarKayFile(global: Bool) throws {
        let url = AarKayPaths.aarkayFile(global: global)
        if !FileManager.default.fileExists(atPath: url.path) {
            try self.write(string: RunnerFiles.aarkayFile, url: url, force: false)
        }
    }

    /// Updates `Package.swift` with `AarKayFile` dependencies.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    /// - Throws: File manager errors
    public static func updatePackageSwift(global: Bool) throws {
        let aarkayFileUrl = AarKayPaths.aarkayFile(global: global)
        let aarkayFileContents = try String(contentsOf: aarkayFileUrl)
        let deps: [Dependency] = try AarKayFile(contents: aarkayFileContents).dependencies
        let contents = RunnerFiles.packageSwift(deps: deps)
        let url = AarKayPaths.packageSwift(global: global)
        try write(string: contents, url: url, force: true)
    }

    /// Writes the string to the destination url atomically and using .utf8 encoding.
    ///
    /// - Parameters:
    ///   - string: The string to write to the file.
    ///   - url: The destination of the file.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func write(string: String, url: URL, force: Bool) throws {
        if force {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
        }
        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true,
            attributes: nil
        )
        try string.write(to: url, atomically: true, encoding: .utf8)
    }
}

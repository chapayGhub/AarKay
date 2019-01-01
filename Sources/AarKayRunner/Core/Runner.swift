//
//  Runner.swift
//  AarKayRunner
//
//  Created by Rahul Katariya on 04/03/18.
//

import Foundation

/// Type that encapsulates creation of all files required by `AarKayRunner`.
class Runner {

    /// Creates all files required to run `AarKay`.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    static func bootstrap(global: Bool = false, force: Bool = false) throws {
        if force {
            let buildUrl = FileManager.buildPath(global: global)
            try FileManager.default.removeItem(at: buildUrl)
        }
        try createCLISwift(global: global, force: force)
        try createPackageSwift(global: global, force: force)
        try createSwiftVersion(global: global, force: force)
        try createAarKayFile(global: global, force: force)
    }

    /// Creates CLI main.swift file
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createCLISwift(global: Bool, force: Bool = false) throws {
        let url = FileManager.mainSwift(global: global)
        try write(string: RunnerFiles.cliSwift, url: url, force: force)
    }
    
    /// Creates Package.swift file
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createPackageSwift(global: Bool, force: Bool = false) throws {
        let url = FileManager.packageSwift(global: global)
        try write(string: RunnerFiles.packageSwift, url: url, force: force)
    }

    /// Creates .swift-version file.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createSwiftVersion(global: Bool, force: Bool = false) throws {
        let url = FileManager.swiftVersion(global: global)
        try write(string: RunnerFiles.swiftVersion, url: url, force: force)
    }

    /// Creates `AarKayFile`.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createAarKayFile(global: Bool, force: Bool = false) throws {
        let url = FileManager.aarkayFile(global: global)
        try write(string: RunnerFiles.aarkayFile, url: url, force: force)
    }
    
    /// Writes the string to the destination url atomically and using .utf8 encoding.
    ///
    /// - Parameters:
    ///   - string: The string to write to the file.
    ///   - url: The destination of the file.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func write(string: String, url: URL, force: Bool) throws {
        if force { try FileManager.default.removeItem(at: url) }
        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true,
            attributes: nil
        )
        try string.write(to: url, atomically: true, encoding: .utf8)
    }
    
}

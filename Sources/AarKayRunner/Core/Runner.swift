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
            let buildUrl = URL.buildPath(global: global)
            if FileManager.default.fileExists(atPath: buildUrl.path) {
                try FileManager.default.removeItem(at: buildUrl)
            }
            let packageResolvedUrl = URL.packageResolved(global: global)
            if FileManager.default.fileExists(atPath: packageResolvedUrl.path) {
                try FileManager.default.removeItem(at: packageResolvedUrl)
            }
        }
        try createCLISwift(global: global, force: force)
        try updatePackageSwift(global: global)
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
        let url = URL.mainSwift(global: global)
        try write(string: RunnerFiles.cliSwift, url: url, force: force)
    }

    /// Creates .swift-version file.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createSwiftVersion(global: Bool, force: Bool = false) throws {
        let url = URL.swiftVersion(global: global)
        try write(string: RunnerFiles.swiftVersion, url: url, force: force)
    }

    /// Creates `AarKayFile`.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    ///   - force: Setting force to true will delete all the files before creating them.
    /// - Throws: File manager errors
    private static func createAarKayFile(global: Bool, force: Bool = false) throws {
        let url = URL.aarkayFile(global: global)
        try write(string: RunnerFiles.aarkayFile, url: url, force: force)
    }
    
    /// Updates `Package.swift` with `AarKayFile` dependencies.
    ///
    /// - Parameters:
    ///   - global: Setting global to true will bootstrap the `AarKay` project inside home directory otherwise will setup in the local directory.
    /// - Throws: File manager errors
    static func updatePackageSwift(global: Bool) throws {
        let aarkayFileUrl = URL.aarkayFile(global: global)
        var urls: [URL] = []
        if let lines = try? String(contentsOf: aarkayFileUrl).components(separatedBy: .newlines) {
            let depUrls = lines
                .filter { !$0.isEmpty }
                .map { URL.init(string: $0) }
                .compactMap { $0 }
            urls = urls + depUrls
        }
        let contents = RunnerFiles.packageSwift(urls: urls)
        let url = URL.packageSwift(global: global)
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

//
//  FileManagerExtensions.swift
//  AarKay
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation

extension FileManager {
    
    /// Creates the url representing the global directory for `AarKay`
    ///
    /// - Returns: The created url.
    static func globalDirectory() -> URL {
        return URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
    }
    
    /// Creates the url reperenting the local directory for `AarKay`.
    ///
    /// - Returns: The created url.
    static func localDirectory() -> URL {
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
    }
    
    /// Decides whether to use global directory or the local directory depending on the global flag.
    ///
    /// - Parameter global: Setting global to true will return the global directory otherwise local directory.
    /// - Returns: The created url.
    static func directoryPath(global: Bool = false) -> URL {
        return global ? globalDirectory() : localDirectory()
    }
    
    /// Creates the url for the root directory of `AarKay`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func aarkayPath(global: Bool = false) -> URL {
        return directoryPath().appendingPathComponent("AarKay", isDirectory: true)
    }
    
    /// Creates the url for the runner directory of `AarKay`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func runnerPath(global: Bool = false) -> URL {
        return aarkayPath(global: global).appendingPathComponent("AarKayRunner", isDirectory: true)
    }
    
    /// Creates the url for the build path of `AarKayRunner`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func buildPath(global: Bool = false) -> URL {
        return runnerPath(global: global).appendingPathComponent(".build", isDirectory: true)
    }
    
    /// Creates the url for the `AarKayRunner` executable.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func cliPath(global: Bool = false) -> URL {
        return buildPath(global: global).appendingPathComponent("release/aarkay-cli")
    }
    
    /// Creates the url for the `main.swift` file of `AarKayRunner`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func mainSwift(global: Bool = false) -> URL {
        return runnerPath(global: global).appendingPathComponent("Sources/AarKayCLI/main.swift")
    }
    
    /// Creates the url of `Package.swift` file of `AarKayRunner`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func packageSwift(global: Bool = false) -> URL {
        return runnerPath(global: global).appendingPathComponent("Package.swift")
    }
    
    /// Creates the url of `.swift-version` file of `AarKayRunner`.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func swiftVersion(global: Bool = false) -> URL {
        return runnerPath(global: global).appendingPathComponent(".swift-version")
    }
    
    /// Creates the url of `AarKayFile` file of `AarKayRunner`. This file is used to add user plugins.
    ///
    /// - Parameter global: Decides whether to construct url relative to global directory or local directory.
    /// - Returns: The created url.
    static func aarkayFile(global: Bool = false) -> URL {
        return aarkayPath(global: global).appendingPathComponent("AarKayFile")
    }
    
}

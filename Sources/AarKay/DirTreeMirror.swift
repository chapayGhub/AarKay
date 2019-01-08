//
//  DirTreeMirror.swift
//  AarKay
//
//  Created by Rahul Katariya on 13/10/17.
//  Copyright © 2017 RahulKatariya. All rights reserved.
//

import Foundation

/// Represents a recursive directory tree shallow mirror with respect to another directory.
///
///     +-----------------------+                   +-----------------------+
///     | - DirOnDisk/*         |                   | - MirrorDir/*         |
///     |-----------------------|                   |-----------------------|
///     |   - SubDir1/          |                   |   - SubDir1/          |
///     |     - SubSubDir1/     |                   |     - SubSubDir1/     |
///     |       - File1.swift   |                   |       - File1.swift   |
///     |       - File2.swift   |                   |       - File2.swift   |
///     |       - File3.txt     | ================> |       - File3.txt     |
///     |     - SubSubDir2/     |                   |     - SubSubDir2/     |
///     |       - File.txt      |                   |       - File.txt      |
///     |   - SubDir2/          |                   |   - SubDir2/          |
///     |     - SubDir/         |                   |     - SubDir/         |
///     |       - File.txt      |                   |       - File.txt      |
///     +-----------------------+                   +-----------------------+
///
/// - note: It only mirrors an existing directory tree with another directory and doesn't create the actual files in the mirrored directory.
public class DirTreeMirror {
    /// The source url.
    let sourceUrl: URL

    /// The destination url.
    let destinationUrl: URL

    /// The file manager.
    let fileManager: FileManager

    /// Initializes the `DirTreeMirror` with source and destination directories.
    ///
    /// - Parameters:
    ///   - sourceUrl: The url of source directory.
    ///   - destinationUrl: The url of destination directory.
    ///   - fileManager: The file manager.
    public init(
        sourceUrl: URL,
        destinationUrl: URL,
        fileManager: FileManager = FileManager.default
    ) {
        self.sourceUrl = sourceUrl
        self.destinationUrl = destinationUrl
        self.fileManager = fileManager
    }

    /// Starts the mirroring of the source directory with the destination directory and executes a block with each source path and its respected mirror path.
    ///
    /// - Parameter fileBlock: The block to execute with source url and its mirror.
    /// - Throws: An error if reading subpathsOfDirectory returns nil.
    public func bootstrap(fileBlock: (URL, URL) -> Void) throws {
        let subpaths = try fileManager.subpathsOfDirectory(atPath: sourceUrl.path)
        let subUrls: [URL] = subpaths
            .filter { return !$0.hasPrefix(".") }
            .map {
                return URL(
                    fileURLWithPath: $0,
                    isDirectory: sourceUrl.appendingPathComponent($0).hasDirectoryPath,
                    relativeTo: sourceUrl
                )
            }
        subUrls.forEach {
            let newUrl = URL(fileURLWithPath: $0.relativePath, isDirectory: $0.hasDirectoryPath, relativeTo: destinationUrl)
            let directoryUrl = newUrl.hasDirectoryPath ? newUrl : newUrl.deletingLastPathComponent()
            try! FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            if !$0.hasDirectoryPath { fileBlock($0, newUrl) }
        }
    }
}

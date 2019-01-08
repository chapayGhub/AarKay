//
//  FileManagerGitExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 01/01/19.
//

import Foundation

extension FileManager: GitExtensionsProvider {}

extension Git where Base == FileManager {
    /// Checks whether the directory has files present inside and if there are files, then it checks whether it is a clean git repository without uncomitted changes.
    ///
    /// - Parameter url: The url of directory.
    /// - Returns: False if the directory is dirty otherwise true.
    /// - Throws: An error if url contents return nil.
    func isDirty(url: URL) throws -> Bool {
        let contents = try base.contentsOfDirectory(atPath: url.path)
            .filter { $0 != ".DS_Strore" }
        // Return false if the directory is empty
        guard contents.count != 0 else { return false }

        // Whether the url is a git directory
        let status = BashProcess.run(
            command: "[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1",
            url: url
        )
        // Return false if the directory is not a git repository
        guard status == 0 else { return false }

        return BashProcess.run(
            command: "git diff --quiet HEAD",
            url: url
        ) == 0 ? false : true
    }
}

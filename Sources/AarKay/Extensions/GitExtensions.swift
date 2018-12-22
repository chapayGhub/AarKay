//
//  AarKayGitExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 22/12/18.
//

import Foundation

public protocol GitExtensionsProvider {}

extension GitExtensionsProvider {
    
    public var git: Git<Self> {
        return Git(self)
    }
    
    public static var git: Git<Self>.Type {
        return Git<Self>.self
    }
    
}

public struct Git<Base> {
    
    public let base: Base
    
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

extension FileManager: GitExtensionsProvider {}

extension Git where Base == FileManager {
    
    func isDirty(url: URL) -> Bool {
        if isEmpty(url: url) { return false }
        return BashProcess.run(
            command: "git diff --quiet HEAD",
            cwd: url
        ) == 0 ? false : true
    }
    
    private func isEmpty(url: URL) -> Bool {
        let status = BashProcess.run(
            command: "[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1",
            cwd: url
        )
        let contents = try? base.contentsOfDirectory(atPath: url.path)
            .filter { $0 == ".DS_Strore" }
        if let contents = contents, contents.count == 0, status != 0 {
            return true
        }
        return false
    }
    
}

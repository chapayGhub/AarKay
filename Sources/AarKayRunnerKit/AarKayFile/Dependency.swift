//
//  Dependency.swift
//  AarKayRunnerKit
//
//  Created by RahulKatariya on 06/01/19.
//

import Foundation

public struct Dependency {
    let url: URL
    let version: VersionType
    
    public init(string: String) throws {
        let comps = string.components(separatedBy: ",")
        guard comps.count == 2,
            let url = URL(string: comps[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                throw AarKayError.parsingError
        }
        self.url = url
        try self.version = VersionType(string: comps[1].trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    public func packageDescription() -> String {
        var path = self.url.absoluteString
        if path.hasPrefix("./") { path = "./." + path }
        return ".package(url: \"\(path)\", \(version.description())),"
    }
    
    public func targetDescription() -> String {
        var url = self.url
        if url.absoluteString.hasSuffix(".git") { url = url.deletingPathExtension() }
        return "\"\(url.lastPathComponent)\","
    }
}

//
//  AarKayFile.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 04/01/19.
//

import Foundation

public struct AarKayFile {
    public let dependencies: [PackageDependency]
    
    public init(url: URL) throws {
        if let lines = try? String(contentsOf: url).components(separatedBy: .newlines) {
            let lines = lines.filter { !$0.isEmpty }
            dependencies = try lines.map { try PackageDependency(string: $0) }
        } else {
            throw AarKayError.parsingError
        }
    }
}

public struct PackageDependency {
    enum VersionType {
        case exact(String)
        case upToMajor(String)
        case upToMinor(String)
        case branch(String)
        case revision(String)
        
        init(string: String) throws {
            let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
            if str.hasPrefix("~> ") {
                let startIndex = str.index(str.startIndex, offsetBy: 3)
                let version = String(str[startIndex...])
                let components = version.components(separatedBy: ".")
                guard components.count == 2 || components.count == 3 else {
                    throw AarKayError.parsingError
                }
                if components.count == 2 {
                    self = .upToMajor(version + ".0")
                } else {
                    self = .upToMinor(version)
                }
            } else if str.hasPrefix("b-") {
                let startIndex = str.index(str.startIndex, offsetBy: 2)
                let version = String(str[startIndex...])
                guard !version.isEmpty else { throw AarKayError.parsingError }
                self = .branch(version)
            } else if str.hasPrefix("r-") {
                let startIndex = str.index(str.startIndex, offsetBy: 2)
                let version = String(str[startIndex...])
                guard !version.isEmpty else { throw AarKayError.parsingError }
                self = .revision(version)
            } else if str.components(separatedBy: ".").count == 3 {
                self = .exact(str)
            } else {
                throw AarKayError.parsingError
            }
        }
        
        public func description() -> String {
            switch self {
            case .exact(let version): return ".exact(\"\(version)\")"
            case .upToMajor(let version): return ".upToNextMajor(from: \"\(version)\")"
            case .upToMinor(let version): return ".upToNextMinor(from: \"\(version)\")"
            case .branch(let version): return ".branch(\"\(version)\")"
            case .revision(let version): return ".revision(\"\(version)\")"
            }
        }
    }

    public let url: URL
    let version: VersionType
    
    public init(string: String) throws {
        let comps = string.components(separatedBy: ",")
        guard comps.count == 2,
            let url = URL(string: comps[0].trimmingCharacters(in: .whitespaces)) else {
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
        if url.path.hasSuffix(".git") { url = url.deletingPathExtension() }
        return "\"\(url.lastPathComponent)\","
    }
}

//
//  AarKayFile.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 04/01/19.
//

import Foundation

struct PackageDependency {
    enum Version {
        case exact(String)
        case upToMajor(String)
        case upToMinor(String)
        case branch(String)
        case revision(String)
        
        init(string: String) throws {
            let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
            if str.hasPrefix("> ") {
                let startIndex = str.index(str.startIndex, offsetBy: 2)
                let version = String(str[startIndex...])
                guard version.components(separatedBy: ".").count == 3 else { throw AarKayError.parsingError }
                self = .upToMajor(version.trimmingCharacters(in: .whitespacesAndNewlines))
            } else if str.hasPrefix("~> ") {
                let startIndex = str.index(str.startIndex, offsetBy: 3)
                let version = String(str[startIndex...])
                guard version.components(separatedBy: ".").count == 3 else { throw AarKayError.parsingError }
                self = .upToMinor(version.trimmingCharacters(in: .whitespacesAndNewlines))
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
        
        func description() -> String {
            switch self {
            case .exact(let version): return ".exact(\"\(version)\")"
            case .upToMajor(let version): return ".upToNextMajor(from: \"\(version)\")"
            case .upToMinor(let version): return ".upToNextMinor(from: \"\(version)\")"
            case .branch(let version): return ".branch(\"\(version)\")"
            case .revision(let version): return ".revision(\"\(version)\")"
            }
        }
    }

    let url: String
    let version: Version
    
    init(string: String) throws {
        let comps = string.components(separatedBy: ",")
        guard comps.count == 2 else { throw AarKayError.parsingError }
        self.url = comps[0].trimmingCharacters(in: .whitespaces)
        try self.version = Version(string: comps[1].trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func packageDescription() -> String {
        return ".package(url: \"\(url)\", \(version.description())),"
    }
    
    func targetDescription() -> String {
        var url = URL(fileURLWithPath: self.url)
        if url.path.hasSuffix(".git") {
            url = url.deletingPathExtension()
        }
        return "\"\(url.lastPathComponent)\","
    }
}

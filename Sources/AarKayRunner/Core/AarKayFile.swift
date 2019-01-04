//
//  AarKayFile.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 04/01/19.
//

import Foundation

struct AarKayFile {
    let dependecies: [PackageDependency]
    
    init(url: URL) throws {
        if let lines = try? String(contentsOf: url).components(separatedBy: .newlines) {
            let lines = lines.filter { !$0.isEmpty }
            dependecies = try lines.map { try PackageDependency(string: $0) }
        } else {
            throw AarKayError.parsingError
        }
    }
}

struct PackageDependency {
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
    let version: VersionType
    
    init(string: String) throws {
        let comps = string.components(separatedBy: ",")
        guard comps.count == 2 else { throw AarKayError.parsingError }
        self.url = comps[0].trimmingCharacters(in: .whitespaces)
        try self.version = VersionType(string: comps[1].trimmingCharacters(in: .whitespacesAndNewlines))
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

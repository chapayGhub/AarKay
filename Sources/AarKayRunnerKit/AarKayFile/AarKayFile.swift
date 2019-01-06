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

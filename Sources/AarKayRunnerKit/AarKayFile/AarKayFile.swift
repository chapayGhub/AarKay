//
//  AarKayFile.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 04/01/19.
//

import Foundation

public struct AarKayFile {
    public let dependencies: [PackageDependency]
    
    public init(contents: String) throws {
        let lines = contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
        dependencies = try lines.map { try PackageDependency(string: $0) }
    }
}

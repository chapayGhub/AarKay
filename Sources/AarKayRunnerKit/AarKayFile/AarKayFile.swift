//
//  AarKayFile.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 04/01/19.
//

import Foundation

public struct AarKayFile {
    public let dependencies: [Dependency]

    public init(contents: String) throws {
        let lines = contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
        dependencies = try lines.map { try Dependency(string: $0) }
    }
}

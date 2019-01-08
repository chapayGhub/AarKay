//
//  Version.swift
//  AarKayRunnerKit
//
//  Created by RahulKatariya on 06/01/19.
//

import Foundation

struct Version {
    let major: Int
    let minor: Int
    let patch: Int

    init(string: String) throws {
        let components = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ".")
        guard components.count == 3,
            let major = Int(components[0]),
            let minor = Int(components[1]),
            let patch = Int(components[2]) else {
            throw AarKayError.parsingError
        }
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    func description() -> String {
        return "\(self.major).\(self.minor).\(self.patch)"
    }
}

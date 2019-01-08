//
//  YamlInputSerializer.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 27/02/18.
//

import Foundation
import Yams

public final class YamlInputSerializer: InputSerializable {
    public func context(contents: String) throws -> Any? {
        return try YamlInputSerializer.load(contents)
    }
}

extension YamlInputSerializer {
    public static func load(_ yaml: String) throws -> Any? {
        return try Yams.load(yaml: yaml)
    }
}

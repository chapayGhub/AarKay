//
//  Generatedfile.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 31/12/17.
//

import Foundation

public struct Generatedfile {
    public var plugin: String
    public var name: String
    public var directory: String?
    public var contents: [String: Any]?
    public var override: Bool
    public var template: String
    public var templateString: String?
    public var ext: String?
    
    public init(
        plugin: String,
        name: String,
        directory: String?,
        contents: [String: Any]?,
        override: Bool,
        template: String
    ) {
        self.plugin = plugin
        self.directory = directory
        self.name = name
        self.contents = contents ?? [:]
        self.override = override
        self.template = template
    }
}

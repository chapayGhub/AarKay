//
//  Datafile.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 31/12/17.
//

import Foundation

public struct Datafile {
    public let plugin: String
    public let name: String
    public let directory: String
    public let template: String
    public let contents: String
    public let globalContext: [String: Any]?
    
    init(plugin: String,
         name: String,
         directory: String,
         template: String,
         contents: String,
         globalContext: [String: Any]?
    ) {
        self.plugin = plugin
        self.name = name
        self.directory = directory
        self.template = template
        self.contents = contents
        self.globalContext = globalContext
    }
}

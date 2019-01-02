//
//  Datafile.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 31/12/17.
//

import Foundation

struct Datafile {
    let plugin: String
    let name: String
    let template: String
    let contents: String
    let globalContext: [String: Any]?
    
    init(plugin: String,
         name: String,
         template: String,
         contents: String,
         globalContext: [String: Any]?
    ) {
        self.plugin = plugin
        self.name = name
        self.template = template
        self.contents = contents
        self.globalContext = globalContext
    }
}

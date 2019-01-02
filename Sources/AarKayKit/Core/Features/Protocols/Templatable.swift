//
//  Templatable.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 29/12/17.
//

import Foundation

public protocol Templatable: class {
    
    var generatedfile: Generatedfile { get set }
    
    init?(generatedfile: Generatedfile) throws 
    func generatedfiles() -> [Generatedfile]
    
    func rk_filename() -> String
    func rk_directory() -> String?
    static func resource() -> String
    static func inputSerializer() -> InputSerializable
    
}

extension Templatable {
    
    public func rk_filename() -> String {
        return generatedfile.name
    }
    
    public func rk_directory() -> String? {
        return generatedfile.directory
    }
    
    public func rk_generatedfile() -> Generatedfile {
        let generatedfile = Generatedfile(
            plugin: self.generatedfile.plugin,
            name: rk_filename(),
            directory: rk_directory(),
            contents: self.generatedfile.contents,
            override: self.generatedfile.override,
            template: self.generatedfile.template
        )
        return generatedfile
    }
    
    public func generatedfiles() -> [Generatedfile] {
        return [rk_generatedfile()]
    }
    
    public static func inputSerializer() -> InputSerializable {
        return YamlInputSerializer()
    }
    
}

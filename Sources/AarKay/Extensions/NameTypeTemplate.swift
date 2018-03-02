//
//  NameTypeTemplate.swift
//  AarKay
//
//  Created by RahulKatariya on 24/08/18.
//

import Foundation

class NameTemplate {
    
    let template: String
    let name: String

    init(string: String) {
        let components = string.components(separatedBy: ".")
        template = components[components.count-2]
        name = components.first!
    }
    
}

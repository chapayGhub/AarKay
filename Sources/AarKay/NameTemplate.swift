//
//  NameTypeTemplate.swift
//  AarKay
//
//  Created by RahulKatariya on 24/08/18.
//

import Foundation

class NameTemplate {
    
    let name: String
    let template: String

    init(string: String) {
        let components = string.components(separatedBy: ".")
        name = components.first!
        template = components[components.count-2]
    }
    
}
